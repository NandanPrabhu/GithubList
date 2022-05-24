//
//  LoginViewModel.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 20/05/22.
//

import Combine
import Foundation

//    let password: PassthroughSubject<String, Never>
//    let userName: PassthroughSubject<String, Never>

class LoginInput: ObservableObject {
    @Published var password: String = ""
    @Published var userName: String = ""
}

class LoginOutput: ObservableObject {
    @Published var loginButtonEnabled: Bool = false
}

class LoginViewModel: ViewModelTransformable {
    var cancellable: Set<AnyCancellable> = []
    let output = LoginOutput()
    func transform(input: LoginInput) -> LoginOutput {
        input.$password.combineLatest(input.$userName)
            .map { tuple -> Bool in
                !tuple.0.isEmpty && !tuple.1.isEmpty
            }.receive(on: DispatchQueue.main)
            .sink { enabled in
                self.output.loginButtonEnabled = enabled
            }.store(in: &cancellable)
        
        return output
    }
}
