//
//  HomeViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainNavigationController: UINavigationController, LoginViewControllerDelegate, HomeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLoggedIn() {
            perform(#selector(showLoginController), with: nil, afterDelay: 0)
        } else {
            setupViewControllers()
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
        guard let accessToken = UserDefaults.standard.getAccessToken() else {
            return
        }
        print("access token: \(accessToken.access_token)")
    }
    
    func signedOut() {
        viewControllers = []
        Auth.sharedInstance.signOut()
        showLoginController()
    }
}
