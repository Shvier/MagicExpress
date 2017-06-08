//
//  DatabaseManager.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa
import FMDB

class DatabaseManager: NSObject {
    
    static let sharedInstance = DatabaseManager()
    
    var database: FMDatabase?
    
    let fileManager = FileManager.default
    let databaseOriginalPath = Bundle.main.path(forResource: "MagicExpress", ofType: "db")
    let databasePath: String = {
        return NSHomeDirectory().appending("/Library/\(Bundle.main.bundleIdentifier!)/Database/MagicExpress.db")
    }()
    let libaryPath: String = {
        return NSHomeDirectory().appending("/Library/\(Bundle.main.bundleIdentifier!)/Database")
    }()
    
    func checkDatabaseFile() -> Bool {
        return fileManager.fileExists(atPath: databasePath)
    }
    
    override init() {
        super.init()
        if !checkDatabaseFile() {
            if !fileManager.fileExists(atPath: libaryPath) {
                do {
                    try fileManager.createDirectory(atPath: libaryPath, withIntermediateDirectories: true, attributes: nil)
                } catch (let error) {
                    print("create path error: \(error)")
                }
            }
            do {
                try fileManager.copyItem(atPath: databaseOriginalPath!, toPath: databasePath)
            } catch (let error) {
                print("database init error: \(error)")
            }
        }
        database = FMDatabase(path: databasePath)
    }

}
