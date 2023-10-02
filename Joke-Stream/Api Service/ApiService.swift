//
//  ApiService.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import Foundation

// Enum to represent possible API errors
enum APIError: Error {
    case invalidResponse
    case networkError
}

// Protocol for the Joke API service
protocol JokeAPIServiceProtocol {
    func fetchJoke(completion: @escaping (Result<String, Error>) -> Void)
}

// Implementation of the Joke API service
class JokeAPIService: JokeAPIServiceProtocol {
    func fetchJoke(completion: @escaping (Result<String, Error>) -> Void) {
        let apiUrl = URL(string: "https://geek-jokes.sameerkumar.website/api")!
        let session = URLSession.shared
        
        let task = session.dataTask(with: apiUrl) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let jokeText = String(data: data, encoding: .utf8) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            completion(.success(jokeText))
        }
        
        task.resume()
    }
}
