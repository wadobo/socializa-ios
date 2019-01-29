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
    }
    
    func start() {
        if !isLoggedIn() {
            showLoginViewController()
        } else {
            showHomeViewController()
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func showLoginViewController() {
        let loginController = LoginViewController()
        loginController.coordinator = self
        navigationController.present(loginController, animated: true, completion: nil)
    }
    
    fileprivate func showHomeViewController() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func signIn() {
        navigationController.dismiss(animated: true, completion: nil)
        showHomeViewController()
        guard let accessToken = UserDefaults.standard.getAccessToken() else {
            return
        }
        print("access token: \(accessToken.access_token)")
    }
    
    func signOff() {
        Auth.sharedInstance.signOut()
        showLoginViewController()
    }
}
