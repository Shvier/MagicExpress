//
//  ShipperTable.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

class ShipperTable: BaseTable {
    
    static func insertShipper(shipper: ShipperModel) {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return
        }
        if shipper.logisticCode == nil || shipper.shipperCode == nil || shipper.updateTime == nil || shipper.traces == nil {
            return
        }
        do {
            try DatabaseManager.sharedInstance.database?.executeUpdate("INSERT INTO Shipper (logistic_code, shipper_code, update_time)" + "VALUES (?, ?, ?)", values: [shipper.logisticCode!, shipper.shipperCode!, shipper.updateTime!])
            for trace in shipper.traces! {
                try DatabaseManager.sharedInstance.database?.executeUpdate("INSERT INTO Trace (shipper_code, logistic_code, accept_time, accept_station)" + "VALUES (?, ?, ?, ?)", values: [shipper.shipperCode!, shipper.logisticCode!, trace.acceptTime!, trace.acceptStation!])
            }
        } catch (let error) {
            print("insert error: \(error)")
        }
        DatabaseManager.sharedInstance.database?.close()
    }
    
    static func deleteShipper(logisticCode: String!, shipperCode: String!) {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return
        }
        do {
            try DatabaseManager.sharedInstance.database?.executeUpdate("DELETE FROM Shipper WHERE logistic_code = ? AND shipper_code = ?", values: [logisticCode, shipperCode])
            try DatabaseManager.sharedInstance.database?.executeUpdate("DELETE FROM Trace WHERE logistic_code = ? AND shipper_code = ?", values: [logisticCode, shipperCode])
        } catch (let error) {
            print("insert error: \(error)")
        }
        DatabaseManager.sharedInstance.database?.close()
    }
    
    static func getShipper(logisticCode: String, shipperCode: String) -> ShipperModel {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return ShipperModel()
        }
        do {
            
        }
        return ShipperModel()
    }

}
