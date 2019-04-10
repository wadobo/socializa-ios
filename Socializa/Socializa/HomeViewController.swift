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

class HomeViewController: UIViewController, MoreMenuDelegate {
    weak var coordinator: MainCoordinator?

    let moreMenu = MoreMenu(options: ["Sign out"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moreMenu.delegate = self
        navigationItem.title = "Socializa"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(didPressMenu))
        view.backgroundColor = .yellow
    }
    
    @objc func didPressMenu() {
        moreMenu.show()
    }
    
    func didSelectMenu(option: String) {
        switch option {
        case "Sign out":
            coordinator?.signOff()
        default:
            fatalError("unknown menu option")
        }
    }
}
