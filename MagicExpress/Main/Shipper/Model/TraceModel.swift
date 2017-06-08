//
//  TraceModel.swift
//  MagicExpress
//
//  Created by Shvier on 07/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class TraceModel: NSObject {

    var logisticCode: String?
    var shipperCode: String?
    var acceptStation: String?
    var acceptTime: String?
    
    static func == (left: TraceModel, right: TraceModel) -> Bool {
        return (left.logisticCode == right.logisticCode) && (left.shipperCode == right.shipperCode) && (left.acceptStation == right.acceptStation) && (left.acceptTime == right.acceptTime)
    }
    
}
