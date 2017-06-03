//
//  SystemManger.swift
//  MagicExpress
//
//  Created by Shvier on 20/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class SystemManger: NSObject {

    static func uuid() -> String {
        let process = Process()
        process.launchPath = "/usr/sbin/ioreg"
        process.arguments = ["-rd1", "-c", "IOPlatformExpertDevice"]
        let pipe = Pipe()
        process.standardOutput = pipe
        let fileHandle = pipe.fileHandleForReading
        process.launch()
        let data = fileHandle.readDataToEndOfFile()
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let key: NSString = "IOPlatformUUID"
        var range = string?.range(of: key as String)
        let location = (range?.location)! + key.length + 5
        let length = 32 + 4
        range?.location = location
        range?.length = length
        let uuid = string?.substring(with: range!).replacingOccurrences(of: "-", with: "")
        return uuid!
    }
    
}
