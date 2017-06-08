//
//  ShipperTable.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

class ShipperTable: BaseTable {
    
    static func checkDataExistInShipper(logisticCode: String, shipperCode: String) -> Bool {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return false
        }
        do {
            let result = try DatabaseManager.sharedInstance.database?.executeQuery("SELECT COUNT(update_time) AS countNum FROM Shipper WHERE logistic_code = ? AND shipper_code = ?", values: [logisticCode, shipperCode])
            while (result?.next())! {
                let count = result?.int(forColumn: "countNum")
                if count != nil && count! > 0 {
                    return true
                } else {
                    return false
                }
            }
            DatabaseManager.sharedInstance.database?.close()
        } catch (let error) {
            print("\(error)")
        }
        return false
    }
    
    static func insertShipper(shipper: ShipperModel, failure: @escaping (_ error: Error) -> Void) {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return
        }
        if shipper.logisticCode == nil || shipper.shipperCode == nil || shipper.updateTime == nil || shipper.traces == nil {
            return
        }
        do {
//            try DatabaseManager.sharedInstance.database?.executeUpdate("INSERT INTO Shipper (logistic_code, shipper_code, update_time)" + "VALUES (?, ?, ?)", values: [shipper.logisticCode!, shipper.shipperCode!, shipper.updateTime!])
            for trace in shipper.traces! {
                try DatabaseManager.sharedInstance.database?.executeUpdate("INSERT INTO Trace (shipper_code, logistic_code, accept_time, accept_station)" + "VALUES (?, ?, ?, ?)", values: [shipper.shipperCode!, shipper.logisticCode!, trace.acceptTime!, trace.acceptStation!])
            }
        } catch (let error) {
            failure(error)
        }
        DatabaseManager.sharedInstance.database?.close()
    }
    
    static func deleteShipper(logisticCode: String!, shipperCode: String!) {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return
        }
        do {
//            try DatabaseManager.sharedInstance.database?.executeUpdate("DELETE FROM Shipper WHERE logistic_code = ? AND shipper_code = ?", values: [logisticCode, shipperCode])
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
            let result = try DatabaseManager.sharedInstance.database?.executeQuery("SELECT * FROM Trace WHERE logistic_code = ? AND shipper_code = ? ORDER BY accept_time", values: [logisticCode, shipperCode])
            let shipper = ShipperModel()
            shipper.logisticCode = logisticCode
            shipper.shipperCode = shipperCode
            var traces = Array<TraceModel>()
            while (result?.next())! {
                let trace = TraceModel()
                trace.logisticCode = logisticCode
                trace.shipperCode = shipperCode
                trace.acceptTime = result?.string(forColumn: "accept_time")
                trace.acceptStation = result?.string(forColumn: "accept_station")
                traces.append(trace)
            }
            shipper.traces = traces
            return shipper
        } catch (let error) {
            print("\(error)")
        }
        return ShipperModel()
    }

}
