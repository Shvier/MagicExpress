//
//  DatabaseManager.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class DatabaseManager: NSObject {
    
    static let sharedInstance = DatabaseManager()
    
    let fileManager = FileManager.default
    let databaseOriginalPath = Bundle.main.path(forResource: "MagicExpress", ofType: "db")
    let databasePath: String = {
        return NSHomeDirectory().appending("/Library/\(Bundle.main.bundleIdentifier!)/Database/MagicExpress.db")
    }()
    
    
    func checkDatabaseFile() -> Bool {
        return fileManager.fileExists(atPath: databasePath)
    }
    
    override init() {
        super.init()
        if !checkDatabaseFile() {
            do {
                try fileManager.copyItem(atPath: databaseOriginalPath!, toPath: databasePath)
            } catch (let error) {
                print("database init error: \(error)")
            }
        }
    }

}
