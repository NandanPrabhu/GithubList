//
//  ContentViewModel.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 31/03/22.
//

import Combine
import SwiftUI

class ContentInput: ObservableObject {
    @Published var searchText: String = ""
}

struct EventPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        
    }
}

class ContentOutput: ObservableObject {
    @Published var results: [Repo] = []
    @Published var apiCallInProgress: Bool = false
    @Published var errorMessage: String = ""
}

protocol ViewModelTransformable {
    associatedtype Input: ObservableObject
    associatedtype Output: ObservableObject
    func transform(input: Input) -> Output
}

class ContentViewModel: ViewModelTransformable {
    var cancellable = Set<AnyCancellable>()
    let output = ContentOutput()
    let service: Service
    init(service: Service = Service()) {
        self.service = service
    }

    func transform(input: ContentInput) -> ContentOutput {
        input.$searchText
            .filter {
                !$0.isEmpty
            }.compactMap { text -> URL? in
                self.output.apiCallInProgress = true
                return URL(string: "https://api.github.com/users/\(text)/repos")
            }.flatMap { url in
                self.service
                    .execute(request: URLRequest(url: url), decodingType: Array<Repo>.self)
            }.receive(on: DispatchQueue.main)
            .sink { status in
                self.output.apiCallInProgress = false
                switch status {
                case .finished:
                    self.output.errorMessage = ""
                case .failure(let error):
                    self.output.errorMessage = error.localizedDescription
                }
            } receiveValue: { results in
                self.output.results = results
            }.store(in: &cancellable)
        return output
    }
}
