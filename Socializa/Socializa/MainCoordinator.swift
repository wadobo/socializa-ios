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
        let vc = NotLoggedInViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func start() {
        if !isLoggedIn() {
            showLoginViewController()
        } else {
            showHomeViewController()
        }
    }
    
    func signIn() {
        navigationController.dismiss(animated: true, completion: nil)
        showHomeViewController()
    }
    
    func signOff() {
        Auth.sharedInstance.signOut()
        showLoginViewController()
        navigationController.popViewController(animated: true)
    }

    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    fileprivate func showLoginViewController() {
        let loginController = LoginViewController()
        loginController.coordinator = self
        navigationController.present(loginController, animated: true, completion: nil)
    }
    
    fileprivate func showHomeViewController() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
