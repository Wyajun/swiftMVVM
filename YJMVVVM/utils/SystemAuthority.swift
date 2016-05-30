//
//  SystemAuthority.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/8.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import SnapKit

let albumSettingTip = "照片被禁用，请在设置-隐私中开启";
let cameraSettingTip = "相机被禁用，请在设置-隐私中开启";

enum AuthorityStatus:Int {
    /// 未知状态
    case SystemAuthorityNone = 0
    /// 1.尚未表态
    case  SystemAuthorityWBT = 1
    /// 2.用户拒绝
    case SystemAuthorityJJ = 2
    /// 3.用户授权
    case SystemAuthoritySQ = 3
}

enum SettingTipTextStatus:Int {
    /// 未知状态
   case  SettingTipTextNone = 0
    /// 1.相册
   case  SettingTipTextAlbum = 1
    /// 2.相机
   case  SettingTipTextCamera = 2
}
/*
typedef enum {
AuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
AuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
AuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
AuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据} CLAuthorizationStatus;
}
*/

class SystemAuthority {
    /// 相册是否授权
    static func albumAuthority()->AuthorityStatus {
        let author = PHPhotoLibrary.authorizationStatus();
        switch author {
        case .Restricted,.Denied:
            return .SystemAuthorityJJ;
        case .Authorized:
            return .SystemAuthoritySQ;
        case .NotDetermined:
            return .SystemAuthorityWBT;
        }
    }
    
    /// 相机是否授权
    static func cameraAuthority()->AuthorityStatus {
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch (authStatus) {
        case .Restricted,.Denied:
            return .SystemAuthorityJJ;
        case .Authorized:
            return .SystemAuthoritySQ;
        case .NotDetermined:
            return .SystemAuthorityWBT;
        }
    }
    
    static func openSetting(showTip:SettingTipTextStatus, showView:UIView?) {
        var tip:String = "" ;
        if (showTip == .SettingTipTextAlbum) {
            tip = albumSettingTip;
        }
        if (showTip == .SettingTipTextCamera) {
            tip = cameraSettingTip;
        }
        
        JDAlertController.alterWithTitle("提示", message: tip, cancelButtonTitle: "取消", otherButtonTitle: "去设置") { (selectIndex) -> Void in
            if selectIndex == 1 {
                let success = UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                if !success {
                    toastNormalMessage("自动跳转失败,请退出程序,手动设置")
                }
            }else {
                SystemAuthority.showTip(tip,InView: showView)
            }
            
        }
    }
    static func showTip(tip:String,InView:UIView?) {
        
        guard InView != nil else {
            return
        }
        let showView = InView!
        
        let backView = UIView();
        showView.addSubview(backView)
        backView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(EdgeInsetsZero)
        }
        let tipLab = creatLab(tip, font: UIFont.systemFontOfText1Font(), titleColor: UIColor.systemWenZiHeader1())
        tipLab.numberOfLines = 0
        backView.addSubview(tipLab)
        tipLab.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(kViewStartX)
            make.right.equalTo(-kViewStartX)
        }
    }
}