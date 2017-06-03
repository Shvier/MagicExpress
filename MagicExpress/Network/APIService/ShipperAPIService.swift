//
//  ShipperAPIService.swift
//  MagicExpress
//
//  Created by Shvier on 03/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ShipperAPIService: NSObject {
    
    static func queryShipper(shipperCode: String, logisticCode: String, success: @escaping (_ shipperResultModel: ShipperResultModel) -> Void, failure: @escaping (_ error: Error) -> Void) {
        HTTPManager.post("http://www.shvier.com:10001", parameters: ["shipperCode": shipperCode, "logisticCode": logisticCode], success: { (data) in
            let json = JSON(data)
            let shipperResultModel = ShipperResultModel()
            shipperResultModel.logisticCode = json["LogisticCode"].string
            shipperResultModel.shipperCode = json["ShipperCode"].string
            let traces = json["Traces"].arrayObject
            for trace in traces as! Array<Dictionary<String, String>> {
                let traceAPIModel = TraceAPIModel()
                traceAPIModel.acceptTime = trace["AcceptTime"]
                traceAPIModel.acceptStation = trace["AcceptStation"]
                shipperResultModel.traces.append(traceAPIModel)
            }
            success(shipperResultModel)
        }) { (error) in
            failure(error)
        }
    }
    
    static func subscribe() {
        
    }

}
