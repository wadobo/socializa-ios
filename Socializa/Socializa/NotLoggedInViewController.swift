//
//  NotLoggedInViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 09/04/2019.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class NotLoggedInViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        setupLayout()
    }
}


extension NotLoggedInViewController {
    func setupLayout() {
        let notLoggedInTextView: UITextView = {
            let textView = UITextView()
            textView.isEditable = false
            textView.translatesAutoresizingMaskIntoConstraints = false
            
            let attributedText = NSMutableAttributedString(
                string: "Not logged in",
                attributes: [
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 40),
                    NSAttributedString.Key.foregroundColor: UIColor.gray
                ]
            )
            
            attributedText.append(NSAttributedString(
                string: "\nPlease, login!...",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
                    NSAttributedString.Key.foregroundColor: UIColor.gray
                ]
            ))
            textView.attributedText = attributedText
            textView.textAlignment = .center
            return textView
        }()
        
        view.addSubview(notLoggedInTextView)
        notLoggedInTextView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        notLoggedInTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        notLoggedInTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
