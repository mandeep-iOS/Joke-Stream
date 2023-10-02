//
//  Helper.swift
//  Joke-Stream
//
//  Created by Deep Baath on 02/10/23.
//

import UIKit

// Utility class to format dates
class DateHelper {
    static func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm:ss a"
        return dateFormatter.string(from: date)
    }
}

class ErrorPresenter {
    static func presentErrorAlert(message: String, inViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

// UILabel extension to calculate the number of lines based on content
extension UILabel {
    func calculateNumberOfLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let text = self.text ?? ""
        let textSize = (text as NSString).boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: self.font ?? UIFont.systemFont(ofSize: 17)],
            context: nil
        )
        let numberOfLines = Int(ceil(textSize.height / self.font.lineHeight))
        return numberOfLines
    }
}

