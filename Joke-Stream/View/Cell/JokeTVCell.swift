//
//  JokeTVCell.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import UIKit

// Custom table view cell for displaying jokes
class JokeTVCell: UITableViewCell {
    
    // Declare outlets for UI elements in your XIB file.
    @IBOutlet weak var jokeTitleLbl: UILabel!
    @IBOutlet weak var timeDateLbl: UILabel!
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    
    // Function to set joke data on the cell
    func setJokeDataOnCell(_joke: Joke){
        let cleanedJokeText = _joke.text.replacingOccurrences(of: "\"", with: "")
        jokeTitleLbl.text = cleanedJokeText
        timeDateLbl.text = DateHelper.format(date: _joke.timestamp)
        
        // Calculate the number of lines based on the content.
        let numberOfLines = jokeTitleLbl.calculateNumberOfLines()
        
        // Adjust the top constraint based on the number of lines.
        if numberOfLines <= 2 {
            labelTopConstraint.constant = 13
        } else {
            labelTopConstraint.constant = 9
        }
    }
}


