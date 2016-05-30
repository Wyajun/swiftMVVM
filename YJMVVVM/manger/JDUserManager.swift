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
    
    var user:TUser!
    // MARK -- 
    static let sharedInstance: JDUserManager = {
        return JDUserManager()
    }()
    
    private override init(){
        
        self.token1 = Defaults[.tokenKey]
        self.siteName = Defaults[.cityName]
        self.siteID = Defaults[.cityID]
        user = TUser(fromDictionary: Defaults[.user_id])
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
        if token.length() > 0 {
            
            if user_Id.length() > 0 {
                getUserInfo({ _  in
                })
                TFWMessageModel.sharedInstance
            }
            return
        }
        refreshToken { _  in
            
        }
    }
    func refreshToken(callback:(success:Bool)->Void) {
        tAuthGetToken(){ (result ) in
            switch result {
            case .error(let code  ,let  message):
                print(message+code)
            case .result(let data) :
                self.token1 = data as? String
                Defaults[.tokenKey] = self.token1
                Defaults.synchronize()
            }
            if !result.httpSuccess && result.codeStatus != .noNetwork {
                self.refreshToken(callback)
            }
            callback(success: result.httpSuccess)
            if result.httpSuccess{
                 NoticeManager.sharedNoticeManager().sendGetNewTokenSuccess()
            }
        }
    }
    
    func tUserSelectSite(siteId:TCityData, callback:(success:Bool)->Void) {
        tSelectSite(siteId.site_id) {
            (result ) in
            switch result {
            case .error( _   ,let  message):
                 toastNormalMessage(message)
            case .result(let data) :
                self.token1 = data as? String
                Defaults[.tokenKey] = self.token1
                Defaults.synchronize()
            }

            if result.httpSuccess {
                self.siteName = siteId.name
                self.siteID = siteId.site_id;
                Defaults[.cityName] = siteId.name
                Defaults[.cityID]  = siteId.site_id
                self.siteName = siteId.name
                Defaults.synchronize()
            }
            callback(success: result.httpSuccess)
             HttpRequestManager.sharedInstance.isGetNewToken = false
            if result.httpSuccess{
                NoticeManager.sharedNoticeManager().sendGetNewTokenSuccess()
            }
           
        }
    }
    
    func login(userName:String,passWord:String,captcha:String ,callback:(success:Bool)->Void) {
        tAuthLogin(userName, password: passWord, captcha: captcha) {
            (result ) in
            switch result {
            case .error( _   ,let  message):
                toastNormalMessage(message)
            case .result(let data) :
                let dic = data as! NSDictionary
                Defaults[.user_id] = dic
                self.user = TUser(fromDictionary: dic)
                self.token1 = dic["token"]! as? String
                Defaults[.tokenKey] = self.token1
                Defaults.synchronize()
            }
            
            callback(success: result.httpSuccess)
            HttpRequestManager.sharedInstance.isGetNewToken = false
            if result.httpSuccess{
                NoticeManager.sharedNoticeManager().sendGetNewTokenSuccess()
            }
            
        }
    }
    func tThirdparty(type:Int,access_token:String,openid:String,callback:(success:Bool)->Void){
        
        tLoginThirdparty(type, access_token: access_token, openid: openid) { (result ) in
            switch result {
            case .error( _   ,let  message):
                toastNormalMessage(message)
            case .result(let data) :
                let dic = data as! NSDictionary
                Defaults[.user_id] = dic
                self.user = TUser(fromDictionary: dic)
                self.token1 = dic["token"]! as? String
                Defaults[.tokenKey] = self.token1
                Defaults.synchronize()
            }
            
            callback(success: result.httpSuccess)
            HttpRequestManager.sharedInstance.isGetNewToken = false
            if result.httpSuccess{
                NoticeManager.sharedNoticeManager().sendGetNewTokenSuccess()
            }
        }
        
    }
    
    func register(userName:String,nickname:String,passWord:String,captcha:String ,callback:(success:Bool)->Void) {
        tAuthRegister(userName, nickname:nickname,password: passWord, captcha: captcha) { (result) in
            switch result {
            case .result(let data):
                let dic = data as! NSDictionary
                Defaults[.user_id] = dic
                self.user = TUser(fromDictionary: dic)
                self.token1 = dic["token"]! as? String
                Defaults[.tokenKey] = self.token1
                Defaults.synchronize()
            case .error(code: _, let  message):
                toastNormalMessage(message)
            }
            callback(success: result.httpSuccess)
            HttpRequestManager.sharedInstance.isGetNewToken = false
            if result.httpSuccess{
                NoticeManager.sharedNoticeManager().sendGetNewTokenSuccess()
            }
            
        }

    }
    func getUserInfo(callback:(success:HttpCodeStatus)->Void) {
      tGetUserInfo( user.userInfo.userId) {  (result) in
       
        switch result {
        case .error( _   ,let  message):
        toastNormalMessage(message)
        case .result(let data) :
        self.user.userInfo = UserInfo(fromDictionary: data as! NSDictionary)
        }
        dispatch_async(dispatch_get_main_queue(), {
         callback(success: result.codeStatus)
        })
       }
    }

    func logout(callback:(success:Bool)->Void) {
        tAuthLogout(){ (result ) in
            switch result {
            case .error(_   ,let  message):
                toastNormalMessage(message)
            case .result(let data) :
                self.token1 = data as? String
                Defaults[.tokenKey] = self.token1
                Defaults[.user_id] = [:]
                self.user = TUser(fromDictionary: [:])
                Defaults.synchronize()
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                 callback(success: result.httpSuccess)
            })
           
        }
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
        guard let user1 = user else {
            return ""
        }
        guard let userInfo = user1.userInfo else {
            return ""
        }
        return userInfo.userId
        
    }
    
    
    // 用户资料完整
    var perfectInfo:Bool {
        get {
            return true
            
        }
    }
    var isLogined:Bool {
        guard let user1 = user else {
            return false
        }
        guard let _ = user1.userInfo else {
            return false
        }
        
        return true
    }
}