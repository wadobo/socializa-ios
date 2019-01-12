//
//  UserDefaults+helper.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 11/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
