//
//  HomeViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func signedOut()
}

class HomeViewController: UIViewController {
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Socializa"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(didPressSignOut))
        view.backgroundColor = .yellow
    }
    
    @objc func didPressSignOut() {
        delegate?.signedOut()
    }
}
