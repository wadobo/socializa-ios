//
//  HomeViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, LoginViewControllerDelegate, HomeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn() {
            setupViewControllers()
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0)
        }
    }
    
    fileprivate func setupViewControllers() {
        let homeViewController = HomeViewController()
        homeViewController.delegate = self
        viewControllers = [homeViewController]
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        loginController.delegate = self
        present(loginController, animated: true, completion: nil)
    }
    
    func finishLoggingIn() {
        setupViewControllers()
    }
    
    func signedOut() {
        viewControllers = []
        showLoginController()
    }
}
