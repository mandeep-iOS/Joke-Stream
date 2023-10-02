//
//  JokeModel.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import Foundation

// Struct to represent a Joke
struct Joke {
    let text: String
    let timestamp: Date
}

// Protocol for the Joke Model delegate
protocol JokeModelDelegate: AnyObject {
    func jokesUpdated(jokes: [Joke])
    func apiErrorOccurred(error: Error)
}

// Model class for managing jokes
class JokeModel {
    weak var delegate: JokeModelDelegate?
    private var jokes: [Joke] = []
    private let apiService: JokeAPIServiceProtocol
    
    init(apiService: JokeAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    // Function to fetch jokes from the API
    func fetchJokes() {
        apiService.fetchJoke { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let jokeText):
                let joke = Joke(text: jokeText, timestamp: Date())
                
                // Prepend the new joke at the beginning of the array.
                self.jokes.insert(joke, at: 0)
                
                // Ensure there are at most 10 jokes in the array.
                if self.jokes.count > 10 {
                    self.jokes.removeLast(self.jokes.count - 10)
                }
                
                // Notify the delegate that jokes have been updated.
                self.delegate?.jokesUpdated(jokes: self.jokes)
                
            case .failure(let error):
                // Notify the delegate about API error.
                self.delegate?.apiErrorOccurred(error: error)
            }
        }
    }
}

