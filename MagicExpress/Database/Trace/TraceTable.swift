//
//  TraceTable.swift
//  MagicExpress
//
//  Created by Shvier on 08/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class TraceTable: NSObject {

    static func getTraces(logisticCode: String, shipperCode: String) -> [TraceModel] {
        if !(DatabaseManager.sharedInstance.database?.open())! {
            DatabaseManager.sharedInstance.database = nil
            return Array<TraceModel>()
        }
        do {
            let result = try DatabaseManager.sharedInstance.database?.executeQuery("SELECT * FROM Trace WHERE logistic_code = ? AND shipper_code = ? ORDER BY accept_time", values: [logisticCode, shipperCode])
            var traces = Array<TraceModel>()
            while (result?.next())! {
                let trace = TraceModel()
                trace.logisticCode = logisticCode
                trace.shipperCode = shipperCode
                trace.acceptTime = result?.string(forColumn: "accept_time")
                trace.acceptStation = result?.string(forColumn: "accept_station")
                traces.append(trace)
            }
            return traces
        } catch (let error) {
            print("\(error)")
        }
        return Array<TraceModel>()
    }

}
