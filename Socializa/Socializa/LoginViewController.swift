//
//  ViewController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol LoginViewControllerDelegate: class {
    func finishLoggingIn()
}

class LoginViewController: UIViewController {
    var facebookProfile: [String:String]?
    
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
    
    let facebookButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "facebook_icon"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didPressFacebookButton), for: .touchUpInside)
        return btn
    }()
    
    let googleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "google_icon"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didPressGoogleButton), for: .touchUpInside)
        return btn
    }()

    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        facebookProfile = nil
        setupLayout()
    }
    
    @objc func didPressFacebookButton() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print(error!)
                return
            }
        
            guard let resultUnwrapped = result else {
                return
            }
            
            guard !resultUnwrapped.isCancelled else {
                return
            }
            
            self.setFacebookProfile(tokenString: resultUnwrapped.token.tokenString)
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.setIsLoggedIn(value: true)
            self.delegate?.finishLoggingIn()
        }
        
    }
    
    @objc func didPressGoogleButton() {
        print("google login")
    }
}

extension LoginViewController {
    private func setupLayout() {
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
        
        leftView.addSubview(facebookButton)
        rightView.addSubview(googleButton)
        
        facebookButton.heightAnchor.constraint(equalTo: leftView.heightAnchor).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleButton.heightAnchor.constraint(equalTo: rightView.heightAnchor).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        googleButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    func setFacebookProfile(tokenString: String) {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                let _ = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                return
            }
            
            guard let resultUnwrapped = result else {
                return
            }
            
            self.facebookProfile = (resultUnwrapped as! [String:String])
            self.facebookProfile?["tokenString"] = tokenString
            
            print(self.facebookProfile ?? "")
        })
    }
}
