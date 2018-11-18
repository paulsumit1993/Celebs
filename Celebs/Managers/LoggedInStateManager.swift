//
//  LoggedInStateManager.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

/// This should ideally be implemented with the keychain APIs in production.

/// Used for managing the user email for future API calls
struct LoggedInStateManager {
    
    static private let loggedInStateString = "isUserLoggedIn"
    static private let userEmail = "userEmail"
    
    private init() {}
    
    static var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: loggedInStateString)
    }
    
    static var email: String? {
        return UserDefaults.standard.string(forKey: userEmail)
    }
    
    static func set(loggedIn state: Bool) {
        UserDefaults.standard.set(state, forKey: loggedInStateString)
    }
    
    static func set(email: String) {
         UserDefaults.standard.set(email, forKey: userEmail)
    }
}

