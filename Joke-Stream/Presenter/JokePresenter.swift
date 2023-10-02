//
//  JokePresenter.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import Foundation

// Protocol for the Joke Presenter delegate
protocol JokePresenterDelegate: AnyObject {
    func updateJokes(jokes: [Joke])
    func showError(message: String)
}

// Presenter class for handling joke fetching
class JokePresenter {
    weak var delegate: JokePresenterDelegate?
    private let model: JokeModel
    private var timer: Timer?
    
    init(model: JokeModel) {
        self.model = model
        self.model.delegate = self
    }
    
    // Function to start fetching jokes periodically
    func startFetchingJokes() {
        // Start a timer to fetch jokes every minute.
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchJokes), userInfo: nil, repeats: true)
        timer?.fire() // Fetch jokes immediately upon starting the app.
    }
    
    // Function to stop fetching jokes
    func stopFetchingJokes() {
        // Stop the timer when needed.
        timer?.invalidate()
    }
    
    // Function to fetch jokes
    @objc private func fetchJokes() {
        // Trigger the model to fetch jokes.
        model.fetchJokes()
    }
}

// Extensions to handle model delegate methods
extension JokePresenter: JokeModelDelegate {
    func jokesUpdated(jokes: [Joke]) {
        // Called when new jokes are fetched or updated.
        delegate?.updateJokes(jokes: jokes)
    }
    
    func apiErrorOccurred(error: Error) {
        // Called when there's an API error.
        delegate?.showError(message: error.localizedDescription)
    }
}
