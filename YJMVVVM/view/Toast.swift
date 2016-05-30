//
//  Toast.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/28.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
let bottomHeight = 100;
let showTimeSeconds = 2.0;

func toastNormalMessage(message:String) {
    Toast.toastNormalMessage(message)
}

 class Toast:NSObject {
    static func toastNormalMessage(message:String) {
        let toastData = ToastData(message: message, showTimeSecondes: Float( showTimeSeconds))
        ToastMgr.sharedInstance.showToastData(toastData)
    }
    static func toastErrorMessage(message:String) {
        
    }
    static func toastSuccessMessage(message:String) {
        
    }

}

private class ToastMgr {
    var toastDatas: [ToastData]
    
    static let sharedInstance: ToastMgr = {
        return ToastMgr()
    }()
    
    init(){
        toastDatas =  [ToastData]()
    }
    func showToastData(toastData:ToastData){
        SynchronizedLock(toastDatas){
            self.toastDatas.append(toastData)
            
            if self.toastDatas.count == 1 {
                if NSThread.isMainThread() {
                   self.showView(toastData)
                }else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showView(toastData)
                    })
                }
            }
        };
    }
    func showView(toastData:ToastData) {
        
        switch toastData.type {
        case .ToastDataNormal:
                self.showNormalView(toastData)
        case .ToastDataSuccess:
            break
        case.ToastDataFail:
            break
        }
    }
    func getFirstToastData()->ToastData? {
        SynchronizedLock(toastDatas){
            self.toastDatas.removeAtIndex(0)
        }
        return self.toastDatas.first
    }
    func showNormalView(toastData:ToastData) {
        
        assert(toastData.message?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0, "显示的message不能为空")
        let backView = UIView()
        backView.backgroundColor = UIColorFromRGB(0x000000).colorWithAlphaComponent(0.85)
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        let messageLab = UILabel()
        messageLab.text = toastData.message;
        messageLab.font = UIFont.systemFontOfText1Font()
        messageLab.textColor = UIColor.systemViewBackgroundColor1()
        messageLab.textAlignment = .Center
        messageLab.numberOfLines = 0
        backView.addSubview(messageLab)
        messageLab.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsMake(CGFloat(kViewSpace),CGFloat(kViewSpace),-CGFloat(kViewSpace),-CGFloat(kViewSpace)))
            make.width.lessThanOrEqualTo(kScreenWidth - 60)
        }
        
        let window:UIWindow;
        if (UIApplication.sharedApplication().windows.count > 1) {
            window = UIApplication.sharedApplication().windows.last!;
        }else{
            window = UIApplication.sharedApplication().windows[0];
        }
        window.addSubview(backView)
        backView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.bottom.equalTo(-bottomHeight)
        }
       
        afterSecRun(toastData.showTimeSecondes){
            backView.removeFromSuperview()
            var data = self.getFirstToastData()
            while data != nil {
            guard toastData.type == data?.type && data?.message == toastData.message else{
                break
              }
              data = self.getFirstToastData()
            }
            
             if let  tmpData = data {
                
                self.showView(tmpData)
             }else {
                
            }
        }
    }
}

private enum ToastDataType:Int {
    case ToastDataNormal
    case ToastDataSuccess
    case ToastDataFail
}

private class ToastData {
    let message :String?
    let showTimeSecondes: Float
    var customView:UIView?
    var type:ToastDataType
    convenience init(message:String,showTimeSecondes:Float) {
        self.init(message: message,showTimeSecondes: showTimeSecondes,type: .ToastDataNormal,customView: nil)
    }
    init(message:String?,showTimeSecondes:Float,type:ToastDataType,customView:UIView?) {
        self.message = message;
        self.showTimeSecondes = showTimeSecondes;
        self.customView = customView;
        self.type = type;
    }
}