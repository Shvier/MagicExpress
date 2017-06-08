//
//  ShipperDataController.swift
//  MagicExpress
//
//  Created by Shvier on 08/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ShipperDataController: NSObject {
    
    static func queryShipper(shipperCode: String, logisticCode: String, success: @escaping (_ shipper: ShipperModel) -> Void, failure: @escaping (_ error: Error) -> Void) {
        ShipperAPIService.queryShipper(shipperCode: shipperCode, logisticCode: logisticCode, success: { (shipperResultModel) in
            var traces = Array<TraceModel>()
            var duplicateTraces = Array<TraceModel>()
            let shipper = ShipperModel()
            shipper.logisticCode = logisticCode
            shipper.shipperCode = shipperCode.utf8String()
            shipper.updateTime = ""
            for trace in shipperResultModel.traces {
                let traceModel = TraceModel()
                traceModel.logisticCode = logisticCode
                traceModel.shipperCode = shipperCode.utf8String()
                traceModel.acceptTime = trace.acceptTime?.utf8String()
                traceModel.acceptStation = trace.acceptStation?.utf8String()

                var isDuplicated: Bool = false
                for duplicateTrace in duplicateTraces {
                    if duplicateTrace == traceModel {
                        isDuplicated = true
                        break
                    }
                }
                if !isDuplicated {
                    duplicateTraces.append(traceModel)
                    traces.append(traceModel)
                    if shipper.updateTime! < trace.acceptTime! {
                        shipper.updateTime = trace.acceptTime?.utf8String()
                    }
                }
            }
            shipper.traces = traces
            success(shipper)
        }) { (error) in
            failure(error)
        }
    }
    
    static func subscribe(shipperCode: String, logisticCode: String, success: @escaping (_ subscribeAPIModel: SubscribeAPIModel) -> Void, failure: @escaping (_ error: Error) -> Void) {
        ShipperAPIService.subscribe(shipperCode: shipperCode, logisticCode: logisticCode, success: { (subscribeModel) in
            success(subscribeModel)
        }) { (error) in
            failure(error)
        }
    }

}
