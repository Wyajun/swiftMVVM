//
//  TUserManagerToken.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/5/12.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
extension JDUserManager {
    func tUserUpData(key:String,conent:String,callback:(success:Bool)->Void) {
        tUserUpDate([key:conent]) {
            (result ) in
            switch result {
            case .error(_   ,let  message):
                toastNormalMessage(message)
            case .result(_ ) : break
            }
            callback(success: result.httpSuccess)
        }
    }
    func tUserUpDateCity(key:String,conent:String,key1:String,conent1:String?,callback:(success:Bool)->Void) {
        var dic:[String:String] = [key:conent]
        if conent1 != nil {
            dic[key1] = conent1
        }
        tUserUpDate(dic) {
            (result ) in
            switch result {
            case .error(_   ,let  message):
                toastNormalMessage(message)
            case .result(_ ) : break
            }
            callback(success: result.httpSuccess)
        }
    }
}