//
//  String+extension.swift
//  MagicExpress
//
//  Created by Shvier on 08/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Foundation

extension String {
    
    func utf8String() -> String {
        return String.init(utf8String: self.cString(using: .utf8)!)!
    }
    
}
