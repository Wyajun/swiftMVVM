//
//  HttpRequestManager.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/23.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import Alamofire

class HttpRequestManager {
    
    let requestQueue:dispatch_queue_t
    var  isLogining:Bool // 标记为taken失效时的处理 登录
    var  isGetNewToken:Bool
    static let sharedInstance: HttpRequestManager = {
        return HttpRequestManager()
    }()
    
    private init(){
       requestQueue = dispatch_queue_create("requestQueue", DISPATCH_QUEUE_SERIAL)
       isLogining = false
       isGetNewToken = false
    }
    
    func cancleAllRequest() {
        
    }
    
    func get(url:String,parameters:[String: String]? ,callback1:HttpResult<AnyObject>->Void) {
        if isGetNewToken {
            let result = httpResultWithDic(["errno":"getNewToken","message":""])
            callback1(result)
            return;
        }
        let paramDic =  JDHttpUtils.addCommonParameters(parameters)
        Alamofire.request(.GET, url, parameters: paramDic).responseJSON { Response in
            if let responseDic = Response.result.value as? [String:AnyObject] {
                let ccb = httpResultWithDic(responseDic)
                callback1(ccb)
                self.dealWithResultCode(ccb)
            }
            if Response.result.isFailure {
                let ccb = httpResultWithDic(self.errorDic())
                callback1(ccb)
            }
        }
    }
    
    
    func post(url:String,parameters:[String: AnyObject]?,callback1:HttpResult<AnyObject> ->Void) {

        if isGetNewToken {
            let result = httpResultWithDic(["errno":"getNewToken","message":"获取token中..."])
            callback1(result)
            return;
        }
        Alamofire.request(.POST, url, parameters: JDHttpUtils.addCommonParameters(parameters)).responseJSON { Response in
            if let responseDic = Response.result.value as? [String:AnyObject] {
                let ccb = httpResultWithDic(responseDic)
                callback1(ccb)
                self.dealWithResultCode(ccb)
            }
            if Response.result.isFailure {
                let ccb = httpResultWithDic(self.errorDic())
                callback1(ccb)
            }
            
        }
    }
    
    func token(url:String,parameters:[String: String]?,callback1:HttpResult<AnyObject> ->Void) {
        
        Alamofire.request(.POST, url, parameters: JDHttpUtils.addCommonParameters(parameters)).responseJSON { Response in
            if let responseDic = Response.result.value as? [String:AnyObject] {
                let ccb = httpResultWithDic(responseDic)
                callback1(ccb)
                self.dealWithResultCode(ccb)
            }
            if Response.result.isFailure {
                let ccb = httpResultWithDic(self.errorDic())
                callback1(ccb)
            }
            
        }
    }
    
    func errorDic()->[String:String] {
        
        if isDisconnentedNetwork() {
            return ["errno":"timeOut","message":"链接服务器失败，稍后重试"]
        }
        return ["errno":"no network","noNetwork":"没有网络，请检查网络"]
    }
    
    func dealWithResultCode(result:HttpResult<AnyObject>) {
        if self.isGetNewToken {
            return
        }
        switch result {
        case .error( _,  _ ) :
                switch result.codeStatus {
                case .token_timeout,.auth_oauth_timeout :
                    self.isGetNewToken = true
                    dispatch_async(requestQueue, {
                        self.getNewToken()
                    });
                case .auth_login_devicechange,.auth_login_notlogin,.auth_login_timeout,.auth_device_change:
                    self.isGetNewToken = true
                    dispatch_async(requestQueue, {
                        self.chuLiAccess_token()
                    });
                case .site_notselect:
                    self.isGetNewToken = true
                    dispatch_async(requestQueue, {
                        self.selectSite()
                    });
                default:break
                }
            default:break
        }
        
    }
    
    func chuLiAccess_token() {
//         presentLoginViewController(true)
    }
    func  selectSite()  {
//        presentTCityListController()
    }
    func getNewToken() {
        JDUserManager.sharedInstance.refreshToken(){
            (success) in
                if success {
                    dispatch_async(self.requestQueue, {
                        self.isGetNewToken = false
                    });
                    
                }
            }
    }
    func isDisconnentedNetwork()->Bool {
        if try! Reachability.reachabilityForInternetConnection().isReachable() {
            return true
        }else {
            return false
        }
    }
}