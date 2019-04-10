//
//  Auth.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 23/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import FBSDKLoginKit
import GoogleSignIn

enum SignInError: Error {
    case EmptyResponse(description: String)
}

extension SignInError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .EmptyResponse(description):
            return description
        }
    }
}

protocol AuthDelegate: GIDSignInUIDelegate {
    func signIn(error: Error?)
}

class Auth: NSObject, GIDSignInDelegate {

    enum Platform: String {
        case facebook
        case google = "google-oauth2"
    }

    static let sharedInstance = Auth()
    
    weak var delegate: AuthDelegate? {
        didSet {
            GIDSignIn.sharedInstance()?.uiDelegate = delegate
        }
    }

    override init() {
        super.init()
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func signIn(platform: Platform, from: UIViewController) {
        switch platform {
        case .facebook:
            facebookLogin(from: from)
        case .google:
            googleLogin()
        }
    }
    
    func signOut() {
        guard let platform = UserDefaults.standard.getPlatform() else {
            return
        }
        
        switch platform {
        case .facebook:
            FBSDKLoginManager().logOut()
        case .google:
            GIDSignIn.sharedInstance()?.signOut()
        }
        
        UserDefaults.standard.clearAccessToken()
    }
    
    fileprivate func facebookLogin(from: UIViewController) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: from) { [unowned self] (result, error) in
            if let error = error {
                self.delegate?.signIn(error: error)
                return
            }
            
            guard let resultUnwrapped = result else {
                self.delegate?.signIn(error: SignInError.EmptyResponse(description: "Empty response from facebook"))
                return
            }
            
            guard !resultUnwrapped.isCancelled else {
                return
            }
            
            self.socializaLogIn(tokenString: resultUnwrapped.token.tokenString, platform: .facebook)
        }
    }
    
    fileprivate func socializaLogIn(tokenString: String, platform: Platform) {
        SocializaBackend.shared.convertToken(tokenString, platform: platform.rawValue) { [unowned self] (result) in
            switch result {
            case .failure(let error):
                self.delegate?.signIn(error: error)
            case .success(let result):
                UserDefaults.standard.setAccessToken(token: result)
                UserDefaults.standard.setPlatform(platform: platform)
                self.delegate?.signIn(error: nil)
            }
        }
    }
    
    fileprivate func googleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    internal func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.delegate?.signIn(error: error)
            return
        }
        
        socializaLogIn(tokenString: user.authentication.accessToken, platform: .google)
    }
}
