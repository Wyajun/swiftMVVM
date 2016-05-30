//
//  JDHttpUtils.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/23.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import UIKit
let  KEY_CHAIN_SERVERNAME = NSBundle.mainBundle().bundleIdentifier
let  deviceTokenKey  = "deviceTokenKey"
class JDHttpUtils {
    
    private static var commendDic:[String:String] = [:]
    
    /// 转换请求参数
    static func addCommonParameters(params:[String:AnyObject]?)->[String:AnyObject] {
        var tmpDic = JDHttpUtils.commendParameterDic();
        tmpDic["token"] = JDUserManager.sharedInstance.token
        guard  let pdic = params else {
            return tmpDic
        }
        for (key,value) in pdic {
            tmpDic[key] = value
        }
        return tmpDic
        
    }
    /// 特定活动参数拼接
    static func huoDonDicToUrl(params:[String:String]) ->String {
        return ""
    }
     /// 默认填充参数
    private static func commendParameterDic() -> [String:AnyObject]{
        if (commendDic.count <= 0) {
            
              let infoDictionary = NSBundle.mainBundle().infoDictionary
              let  minorVersion = infoDictionary!["CFBundleVersion"] as! String
            
            commendDic = ["app_key":"2","app_secret":"CUleSF","app_version":minorVersion,"device":deviceUUID()];
         }
       return commendDic;
    }
    
    private static func deviceUUID()->String {
        return ""
//        let devToken = SSKeychain.passwordForService(KEY_CHAIN_SERVERNAME,account:deviceTokenKey)
//        if devToken != nil {
//            return devToken
//        }
//        let  result = NSUUID().UUIDString
//        SSKeychain.setPassword(result, forService: KEY_CHAIN_SERVERNAME, account: deviceTokenKey)
//        return result;
    }
    
    private static func createMd5Sign(dict:[String:String])->String {
        
        var contentString  = String();
         let  keys = dict.keys ;
        //按字母顺序排序
            
        let  sortedArray = keys.sort(<)
        for key in sortedArray {
            contentString += key;
            contentString += "="
            contentString += dict[key]!
        }
        //添加key字段
        contentString += kSignKey
        //得到MD5 sign签名
        return  JDHttpUtils.md5(contentString);

    }
    private static func md5(str:String )->String{
//        let cStr = str.cStringUsingEncoding(NSUTF8StringEncoding);
//        let strLen = CC_LONG(str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer <CUnsignedChar>.alloc(digestLen);
//        CC_MD5(cStr!, strLen, result);
//        
//        var hash = "";
//        for i in 0 ..< digestLen {
//           hash = String(format: "%@%02x", hash, result[i])
//        }
//        result.destroy();
//        return  hash;
        return ""
    }
    

}