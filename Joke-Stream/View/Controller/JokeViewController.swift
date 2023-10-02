//
//  JokeViewController.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: JokePresenter?
       private var jokes: [Joke] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupTableView()
           setupPresenter()
       }
       
       // MARK: - Private Methods
       
       private func setupTableView() {
           tableView.register(UINib(nibName: "JokeTVCell", bundle: nil), forCellReuseIdentifier: "JokeTVCell")
           tableView.delegate = self
           tableView.dataSource = self
       }
       
       private func setupPresenter() {
           let apiService = JokeAPIService()
           let model = JokeModel(apiService: apiService)
           
           presenter = JokePresenter(model: model)
           presenter?.delegate = self
           presenter?.startFetchingJokes()
       }
}

// Extension to handle presenter delegate methods
extension JokeViewController: JokePresenterDelegate {
    func updateJokes(jokes: [Joke]) {
        // Update the view with the latest jokes.
        self.jokes = jokes
        
        // Reload the table view on the main thread.
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        // Use the ErrorPresenter to display the error alert.
        DispatchQueue.main.async {
            ErrorPresenter.presentErrorAlert(message: message, inViewController: self)
        }
    }
}

// Extensions to conform to UITableViewDataSource and UITableViewDelegate
extension JokeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Unlimint Jokes"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        // Customize the header view's appearance here
        header.contentView.backgroundColor = .clear
        // Customize the title label's appearance
        header.textLabel?.textColor = UIColor(red: 210.0/255.0, green: 245.0/255.0, blue: 96.0/255.0, alpha: 1.0) // Custom RGB color
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        header.textLabel?.textAlignment = .center
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let jokeCell = tableView.dequeueReusableCell(withIdentifier: "JokeTVCell", for: indexPath) as? JokeTVCell else { return UITableViewCell() }
        
        if jokes.count > 0 {
            jokeCell.setJokeDataOnCell(_joke: jokes[indexPath.row])
        }
        
        return jokeCell
    }
}
