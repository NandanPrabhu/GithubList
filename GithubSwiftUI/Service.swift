//
//  Service.swift
//  GithubSwiftUI
//
//  Created by Nandan Prabhu on 31/03/22.
//

import Combine
import Foundation

class Service {
    
    let decoder = JSONDecoder()
    func execute<T: Decodable>(request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { tuple -> Data in
                guard let httpResponse = tuple.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return tuple.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

struct Repo: Decodable, Identifiable {
    let name: String?
    let fullName: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name, id, fullName = "full_name"
    }
}
