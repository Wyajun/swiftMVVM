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
    let  kAppVersion = "kAppVersion"
    // MARK --
    static let sharedInstance: TConfigMgr = {
        return TConfigMgr()
    }()
    
    private override init(){
       
        super.init()
        self.refreshAllCityList()
        
    }
    func refreshAllCityList() {
        let path = NSBundle.mainBundle().resourcePath! + "/TCityJson.json"
        let data = NSData(contentsOfFile:path);
      let array =  try? NSJSONSerialization
        .JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments) as! [[String:String]]
//        for dic in array! {
//            let city = TConfigCityData(fromDictionary: dic)
//            allCityList.append(city)
//        }
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
