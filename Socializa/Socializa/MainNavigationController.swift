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

        setupViewControllers()
        
        if !isLoggedIn() {
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
        let accessToken = UserDefaults.standard.getAccessToken()!
        print("access token: \(accessToken.access_token)")
    }
    
    func signedOut() {
        FBSDKLoginManager().logOut()
        UserDefaults.standard.clearAccessToken()
        showLoginController()
    }
}
