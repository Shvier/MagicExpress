//
//  ShipperResultModel.swift
//  MagicExpress
//
//  Created by Shvier on 03/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

class ShipperResultModel: BaseAPIModel {
    
    lazy var traces: Array<TraceAPIModel> = {
        return Array<TraceAPIModel>()
    }()
    
    var logisticCode: String?
    var shipperCode: String?

}
