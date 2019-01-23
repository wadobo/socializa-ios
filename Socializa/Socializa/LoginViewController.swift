//
//  ViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

protocol LoginViewControllerDelegate: class {
    func finishLoggingIn()
}

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    let facebookLoginButton = ImageButton(image: UIImage(named: "facebook_icon.png")!, target: self, action: #selector(handleFacebookLogin))
    let googleLoginButton = ImageButton(image: UIImage(named: "google_icon.png")!, target: self, action: #selector(handleGoogleLogin))
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @objc func handleFacebookLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { [unowned self] (result, error) in
            if error != nil {
                print("login error: \(error!)")
                return
            }
        
            guard let resultUnwrapped = result else {
                return
            }
            
            guard !resultUnwrapped.isCancelled else {
                return
            }
            
            self.socializaLogIn(tokenString: resultUnwrapped.token.tokenString, platform: .facebook)
        }
        
    }
    
    func socializaLogIn(tokenString: String, platform: SocializaBackend.Platform) {
        SocializaBackend.shared.convertToken(tokenString, platform: platform) { [unowned self] (result, error) in
            if let error = error {
                self.showErrorAlert(message: "An error has occurred: \(error.localizedDescription)")
                print(error)
                return
            }
            
            guard let result = result else {
                self.showErrorAlert(message: "Empty response")
                return
            }

            UserDefaults.standard.setAccessToken(token: result)
            self.dismiss(animated: true, completion: nil)
            self.delegate?.finishLoggingIn()
        }
    }

    @objc func handleGoogleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            return
        }
        
        socializaLogIn(tokenString: user.authentication.accessToken, platform: .google)
    }

}



// MARK: Layout setup
extension LoginViewController {
    fileprivate func setupLayout() {
        let logoView: UIImageView = {
            let logoView = UIImageView(image: UIImage(named: "logo"))
            logoView.translatesAutoresizingMaskIntoConstraints = false
            logoView.contentMode = .scaleAspectFit
            return logoView
        }()
        
        let descriptionView: UITextView = {
            let textView = UITextView()
            textView.isEditable = false
            textView.translatesAutoresizingMaskIntoConstraints = false
            
            let attributedText = NSMutableAttributedString(
                string: "Socializa",
                attributes: [
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 40)
                ]
            )
            
            attributedText.append(NSAttributedString(
                string: "\nThe world is the board game!",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
                    NSAttributedString.Key.foregroundColor: UIColor.gray
                ]
            ))
            textView.attributedText = attributedText
            textView.textAlignment = .center
            return textView
        }()
        
        let topLogoContainerView = UIView()
        view.addSubview(topLogoContainerView)
        topLogoContainerView.translatesAutoresizingMaskIntoConstraints = false
        topLogoContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLogoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLogoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topLogoContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topLogoContainerView.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: topLogoContainerView.centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: topLogoContainerView.centerYAnchor).isActive = true
        logoView.heightAnchor.constraint(equalTo: topLogoContainerView.heightAnchor, multiplier: 0.7).isActive = true
        
        view.addSubview(descriptionView)
        descriptionView.topAnchor.constraint(equalTo: topLogoContainerView.bottomAnchor).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true

        let leftView = UIView()
        let rightView = UIView()
        
        leftView.addSubview(facebookLoginButton)
        rightView.addSubview(googleLoginButton)
        
        facebookLoginButton.heightAnchor.constraint(equalTo: leftView.heightAnchor).isActive = true
        facebookLoginButton.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        facebookLoginButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleLoginButton.heightAnchor.constraint(equalTo: rightView.heightAnchor).isActive = true
        googleLoginButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        googleLoginButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [leftView, rightView])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
