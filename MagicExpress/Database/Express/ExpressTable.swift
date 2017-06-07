//
//  ExpressTable.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

class ExpressTable: BaseTable {
    
    static func getExpressCode(shipperCode: String) -> String {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return ""
        }
        do {
            let utf8ShipperCode: String! = String.init(utf8String: shipperCode.cString(using: .utf8)!)
            let result = try DatabaseManager.sharedInstance.database?.executeQuery("SELECT * FROM Express WHERE express_cn = ?", values: [utf8ShipperCode])
            while (result?.next())! {
                let expressCode: String! = result?.string(forColumn: "express_en")!
                DatabaseManager.sharedInstance.database?.close()
                return expressCode
            }
        } catch (let error) {
            print("query error: \(error)")
        }
        return ""
    }
    
    static func getExpressName() -> [String] {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return [""]
        }
        do {
            let result = try DatabaseManager.sharedInstance.database?.executeQuery("SELECT express_cn FROM Express ORDER BY express_order_name", values: nil)
            var expressNames = Array<String>()
            while (result?.next())! {
                expressNames.append((result?.string(forColumn: "express_cn"))!)
            }
            DatabaseManager.sharedInstance.database?.close()
            return expressNames
        } catch (let error) {
            print("query error: \(error)")
        }
        return [""]
    }

}
