//
//  APIService.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import Foundation
import Combine


enum APIError: Error {
    case invalidResponse
    case dataNotFound
}

class APIService {
    static let shared = APIService()
    
    func getUsers(perPage: Int = 15, since: Int? = nil) -> AnyPublisher<[User], Error> {
        var components = URLComponents(string: "https://api.github.com/users")!
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "since", value: String(describing: since))
        ]
        
        let request = URLRequest(url: components.url!)
        return sendRequest(url: request).eraseToAnyPublisher()
    }
    
    func sendRequest<T: Decodable>(url: URLRequest) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) in
                guard response is HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                return data
            })
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
