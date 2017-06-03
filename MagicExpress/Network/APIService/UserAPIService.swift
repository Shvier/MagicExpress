//
//  UserAPIService.swift
//  MagicExpress
//
//  Created by Shvier on 20/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa
import SwiftyJSON

class UserAPIService: NSObject {
    
    static func register(userid: String, success: @escaping (_ userInfoModel: UserInfoAPIModel) -> Void, failure: @escaping (_ error: Error) -> Void) {
        HTTPManager.post("https://www.shvier.com", parameters: ["userid": userid], success: { (data) in
            let json = JSON(data)
            let userInfoModel = UserInfoAPIModel()
            userInfoModel.userid = json["userid"].string
            success(userInfoModel)
        }) { (error) in
            failure(error)
        }
    }

}
