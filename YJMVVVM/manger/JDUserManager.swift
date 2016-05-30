//
//  JDUserManager.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/29.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let tokenKey = DefaultsKey<String?>("tokenKey")
    static let user_id = DefaultsKey<NSDictionary>("user_id")
    static let cityName = DefaultsKey<String?>("cityName")
    static let cityID = DefaultsKey<String?>("cityID")
}

class JDUserManager:NSObject {
    private var token1:String?
    private var siteName:String?
    private var siteID:String?
    private var getTokenCount:Int
    
//    var user:TUser!
    // MARK --
    static let sharedInstance: JDUserManager = {
        return JDUserManager()
    }()
    
    private override init(){
        
        self.token1 = Defaults[.tokenKey]
        self.siteName = Defaults[.cityName]
        self.siteID = Defaults[.cityID]
//        user = TUser(fromDictionary: Defaults[.user_id])
        getTokenCount = 0
        super.init()
        
    }
    func getToken() {
        if getTokenCount > 3 {
            JDAlertController.alterWithTitle("网络不给力. 关闭app", message: nil, cancelButtonTitle: "关闭", otherButtonTitle: nil, selectIndex: { (selectIndex) in
                exit(0)
            })
            return
        }
        getTokenCount += 1
        if token.length > 0 {
            
            if user_Id.length > 0 {
                getUserInfo({ _  in
                })
//                TFWMessageModel.sharedInstance
            }
            return
        }
        refreshToken { _  in
            
        }
    }
    func refreshToken(callback:(success:Bool)->Void) {
        
    }
    
    
    func login(userName:String,passWord:String,captcha:String ,callback:(success:Bool)->Void) {
        
    }
    func tThirdparty(type:Int,access_token:String,openid:String,callback:(success:Bool)->Void){
        
       
        
    }
    
    func register(userName:String,nickname:String,passWord:String,captcha:String ,callback:(success:Bool)->Void) {
        

    }
    func getUserInfo(callback:(success:HttpCodeStatus)->Void) {
      
    }

    func logout(callback:(success:Bool)->Void) {
        
    }
    
    var token:String {
        get {
            guard let t = token1 else {
                return ""
            }
            return t
        }
    }
    
    var cityName:String {
        get{
            guard let t = siteName else {
                return "全国"
            }
            return t
        }
    }
    var cityID:String {
        get{
            guard let t = siteID else {
                return ""
            }
            return t
        }
    }

    var user_Id:String {
        
        return ""
        
    }
    
    
    // 用户资料完整
    var perfectInfo:Bool {
        get {
            return true
            
        }
    }
    var isLogined:Bool {
        return true
    }
}