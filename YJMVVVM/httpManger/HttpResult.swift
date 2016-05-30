//
//  HttpResult.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/15.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation

enum HttpCodeStatus: String {
    case none = "None"
    case success = "Success"
    case timeOut = "timeOut"
    case  noNetwork = "no network"
    case getNewToken = "getNewToken"
    case token_timeout = "token_timeout"
    case auth_oauth_timeout = "auth_oauth_timeout"
    case auth_login_devicechange = "auth_login_devicechange"
    case  auth_login_notlogin = "auth_login_notlogin"
    case auth_login_timeout = "auth_login_timeout"
    case auth_device_change = "auth_device_change"
    case site_notselect = "site_notselect"
    case user_fillinfo_username = "user_fillinfo_username"
    case loctionGetError = "loctionGetError"
}

enum HttpResult<T> {
    case error(code:String,message:String)
    case result(T)
}
extension HttpResult:HttpResultType {
    init(error: (String,String)) {
        self = .error(code: error.0, message: error.1)
    }
    init(value: T ) {
        self = .result(value)
    }
    var codeStatus:HttpCodeStatus {
        get {
            switch self {
            case .error(let code , _):
                if let httpCode = HttpCodeStatus(rawValue: code) {
                    return httpCode
                }else {
                    return .none
                }
            case .result(_ ):
                return .success
            }
        }
    }
    var httpSuccess:Bool {
        switch self {
        case .error(_ , message: _):
            return false
        case .result(_):
            return true
        }
    }
    
}

 func httpResultWithDic(responesd:[String:AnyObject])->HttpResult<AnyObject> {
    let code = anyObjectToString(responesd["errno"])
    if code == "" {
        return HttpResult(value: responesd["data"]! )
    }
    return HttpResult(error: (code,anyObjectToString(responesd["message"])))
}


protocol HttpResultType {
    associatedtype Value
    associatedtype Error = (String,String)
    init(value:Value)
    init(error:Error)
    var codeStatus:HttpCodeStatus {get}
}