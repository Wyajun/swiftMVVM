//
//  TMapMgr.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/5/14.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation

//class TMapMgr: NSObject,BMKGeneralDelegate,BMKLocationServiceDelegate {
//    let  _mapManager: BMKMapManager
//    let  locationService:BMKLocationService
//    // MARK --
//    static let sharedInstance: TMapMgr = {
//        return TMapMgr()
//    }()
//    
//    private override init(){
//        _mapManager = BMKMapManager()
//        locationService = BMKLocationService()
//        super.init()
//        _mapManager.start("iDvEwjGuPGieyUyAzGUBqFWl2njvQ6kK", generalDelegate: self)
//        locationService.delegate = self;
//    }
//    func onGetNetworkState(iError: Int32) {
//        if (0 == iError) {
//            NSLog("联网成功");
//        }
//        else{
//            NSLog("联网失败，错误代码：Error\(iError)");
//        }
//    }
//    
//    func onGetPermissionState(iError: Int32) {
//        if (0 == iError) {
//            NSLog("授权成功");
//        }
//        else{
//            NSLog("授权失败，错误代码：Error\(iError)");
//        }
//    }
//    var location:((l : CLLocation?)->Void)!
//    
//    func didFailToLocateUserWithError(error: NSError!) {
//        if location != nil {
//            location(l: nil)
//        }
//    }
//    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
//        
//    }
//    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
//        if location != nil {
//            location(l: userLocation.location)
//        }
//    }
//}
