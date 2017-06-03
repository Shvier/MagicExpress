//
//  HTTPManager.swift
//  MagicExpress
//
//  Created by Shvier on 18/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa
import Alamofire

class HTTPManager: NSObject {
    
    static let headers: HTTPHeaders = ["Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                                       "Accept": "application/json"]
    
    static func get(_ urlString: String, parameters: Parameters? = nil, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                success(data)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func post(_ urlString: String, parameters: Parameters? = nil, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                success(data)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func put(_ urlString: String, parameters: Parameters? = nil, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(urlString, method: .put, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                success(data)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
    static func delete(_ urlString: String, parameters: Parameters? = nil, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(urlString, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                success(data)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }

}
