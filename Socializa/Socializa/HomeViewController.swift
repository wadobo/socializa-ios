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

enum MenuOptionValue: String {
    case SignOut = "Sign out"
}

class HomeViewController: UIViewController, MoreMenuDelegate {
    weak var coordinator: MainCoordinator?

    lazy var moreMenu: MoreMenu = {
        let signOut = MenuOption(name: .SignOut)
        let menu = MoreMenu(options: [signOut])
        menu.delegate = self
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Socializa"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(didPressMenu))
        view.backgroundColor = .yellow
    }
    
    @objc func didPressMenu() {
        moreMenu.show()
    }
    
    func didSelectMenu(option: MenuOption) {
        switch option.name {
        case .SignOut:
            coordinator?.signOff()
        }
    }
}
