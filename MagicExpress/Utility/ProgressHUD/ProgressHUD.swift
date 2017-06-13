//
//  ProgressHUD.swift
//  MagicExpress
//
//  Created by Shvier on 13/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ProgressHUD: NSObject {

    static func showMessage(content: String, to view: NSView) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.labelText = content
        return hud!
    }
    
}
