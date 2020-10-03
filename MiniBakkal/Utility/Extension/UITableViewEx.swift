//
//  UITableViewEx.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

extension UITableView {
    func showMessage(message: String, containerView: UIView) {
        DispatchQueue.main.async {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = UIColor.darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "Helvetica Neue", size: 25)
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel
        }
        self.separatorStyle = .none
    }

    func hideMessage() {
        DispatchQueue.main.async {
            self.separatorStyle = .singleLine
            self.backgroundView = UIView()
        }
    }
}
