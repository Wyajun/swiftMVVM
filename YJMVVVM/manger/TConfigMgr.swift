//
//  TConfigMgr.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/5/12.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
extension DefaultsKeys {
    static let showIntroduce = DefaultsKey<String?>("showIntroduce")
    
}

class TConfigMgr: NSObject {
    private var allCityList:[TConfigCityData]
    var user:TUser!
    let  kAppVersion = "kAppVersion"
    // MARK --
    static let sharedInstance: TConfigMgr = {
        return TConfigMgr()
    }()
    
    private override init(){
        allCityList = []
        super.init()
        self.refreshAllCityList()
        
    }
    func refreshAllCityList() {
        let path = NSBundle.mainBundle().resourcePath! + "/TCityJson.json"
        let data = NSData(contentsOfFile:path);
      let array =  try? NSJSONSerialization
        .JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments) as! [[String:String]]
        for dic in array! {
            let city = TConfigCityData(fromDictionary: dic)
            allCityList.append(city)
        }
    }
    
    var provinceList:[TConfigCityData] {
        get {
            var arr:[TConfigCityData] = []
            for bean in allCityList {
                if bean.level == "1" {
                    arr.append(bean)
                }
            }
            return arr
        }
    }
    
    func getCityById(placeId:String) -> TConfigCityData? {
        if placeId.isEmpty {
            return nil
        }
        for bean in allCityList {
            if bean.place_id == placeId {
                return bean
            }
        }
        return nil
    }
    
    func getCityByProvince(province:TConfigCityData)->[TConfigCityData] {
        var arr:[TConfigCityData] = []
        for bean in allCityList {
            if bean.parent_id == province.place_id {
                arr.append(bean)
            }
        }
        return arr
    }
 
    var education_level:[String] {
        get {
            return ["不限",
                     "初中及以上学历",
                     "高中及以上学历",
                     "大学及以上学历"]
        }
    }
    var experience_level:[String] {
        get {
            return ["不限",
                    "1年工作经历",
                    "2-3年工作经历",
                    "4-6年工作经历",
                    "7年以上年工作经历"]
        }
    }
    
    var welfare:[String] {
        get {
            return ["不限",
                    "住",
                    "厂车",
                    "工作餐"]
        }
    }
    
    var gender:[String] {
        get {
          return  [
                "不限",
                "男",
                "女"
            ]
        }
    }
    
    var gender1:[String] {
        get {
            return  [
                "保密",
                "男",
                "女"
            ]
        }
    }
    
    var showIntroduce:Bool {
        get {
            let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
            let appVersion = Defaults[.showIntroduce]
            
            if (appVersion == nil || (appVersion != currentVersion) ) {
                Defaults[.showIntroduce] = currentVersion
                Defaults.synchronize()
                return true
            }else {
                return false
            }
        }
    }
    
}
