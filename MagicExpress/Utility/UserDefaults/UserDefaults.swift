//
//  UserDefaults.swift
//  MagicExpress
//
//  Created by Shvier on 20/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

let UserIDKey = "UserIDKey"

class UserDefaults: NSObject {
    
    static func save(key: String, value: Any?) {
        UserDefaults.setValue(value, forKey: key)
    }
    
    static func get(key: String) -> Any? {
        return UserDefaults.value(forKey: key)
    }
    
    static func contain(key: String) -> Bool {
        return UserDefaults.get(key: key) != nil
    }
    
    static func remove(key: String) {
        UserDefaults.remove(key: key)
    }
    
    static func clear() {
        
    }

}
