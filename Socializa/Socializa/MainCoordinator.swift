//
//  MainCoordinator.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 29/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let vc = HomeViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func start() {
        if !isLoggedIn() {
            showLoginViewController()
        }
    }
    
    func signIn() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func signOff() {
        Auth.sharedInstance.signOut()
        showLoginViewController()
    }
    
    func didPressMoreMenu() {
        print("menu pressed...")
    }

    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    fileprivate func showLoginViewController() {
        let loginController = LoginViewController()
        loginController.coordinator = self
        navigationController.present(loginController, animated: true, completion: nil)
    }
}
