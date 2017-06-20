//
//  PushNotificationManager.swift
//  MagicExpress
//
//  Created by shvier on 20/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class PushNotificationManager: NSObject {
    
    static func pushMessage(content: String) {
        let notification = NSUserNotification()
        notification.title = "物流更新"
        notification.informativeText = content
        notification.actionButtonTitle = "查看"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.scheduleNotification(notification)
    }

}
