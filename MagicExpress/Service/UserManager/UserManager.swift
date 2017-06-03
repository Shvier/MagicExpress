//
//  UserManager.swift
//  MagicExpress
//
//  Created by Shvier on 20/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class UserManager: NSObject {
    
    static func isLogin() -> Bool {
        return UserDefaults.contain(key: UserIDKey)
    }

}
