//
//  AppDelegate.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        
        window?.rootViewController = MainNavigationController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        GIDSignIn.sharedInstance().clientID = "180959654042-h06php5v00tvo9ojfd7b2shdbt3vjgdr.apps.googleusercontent.com"
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let fbApp = FBSDKApplicationDelegate.sharedInstance() else {
            return false
        }
        
        var handled = fbApp.application(
            app,
            open: url,
            sourceApplication: (options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String),
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        if !handled {
            handled = GIDSignIn.sharedInstance().handle(
                url as URL?,
                sourceApplication: (options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String),
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        }
        
        return handled
    }
}
