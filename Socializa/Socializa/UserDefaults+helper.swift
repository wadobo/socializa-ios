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
        case accessToken
        case tokenType
        case refreshToken
    }
    
    func isLoggedIn() -> Bool {
        return getAccessToken() != nil
    }
    
    func setAccessToken(token: SocializaBackend.AccessToken) {
        set(token.access_token, forKey: UserDefaultsKeys.accessToken.rawValue)
        set(token.refresh_token, forKey: UserDefaultsKeys.refreshToken.rawValue)
        set(token.token_type, forKey: UserDefaultsKeys.tokenType.rawValue)
        synchronize()
    }
    
    func clearAccessToken() {
        removeObject(forKey: UserDefaultsKeys.accessToken.rawValue)
        removeObject(forKey: UserDefaultsKeys.refreshToken.rawValue)
        removeObject(forKey: UserDefaultsKeys.tokenType.rawValue)
    }
    
    func getAccessToken() -> SocializaBackend.AccessToken? {
        guard let at = string(forKey: UserDefaultsKeys.accessToken.rawValue) else {
            return nil
        }
        
        return SocializaBackend.AccessToken(
            access_token: at,
            token_type: string(forKey: UserDefaultsKeys.tokenType.rawValue)!,
            refresh_token: string(forKey: UserDefaultsKeys.refreshToken.rawValue)!
        )
    }
}
