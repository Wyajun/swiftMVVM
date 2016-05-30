//
//  ViewHUD.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/5.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class ViewHUD: UIView {
    let activityView:UIActivityIndicatorView
    init () {
        activityView = UIActivityIndicatorView()
        super.init(frame: CGRectZero)
        let  actBackView = UIView()
        actBackView.backgroundColor = UIColor.blackColor()
        actBackView.layer.cornerRadius = 12
        actBackView.clipsToBounds = true
        actBackView.addSubview(activityView)
        activityView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.size.equalTo(CGSizeMake(36, 36))
        }
        self.addSubview(actBackView)
        actBackView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.size.equalTo(CGSizeMake(78, 78))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    private struct ProgressHUD {
        static var HUB:ViewHUD?
    }
    private var hub:ViewHUD? {
        get {
            return objc_getAssociatedObject(self, &ProgressHUD.HUB) as? ViewHUD
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &ProgressHUD.HUB, value as AnyObject?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    func showProgressHUD() {
        
        let hub: ViewHUD
        if let  tmphub = self.hub {
            hub = tmphub
        }else {
            hub = ViewHUD()
        }
        self.addSubview(hub)
        self.hub = hub
        hub.activityView.startAnimating()
        hub.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(EdgeInsetsMake(0,left: 0,bottom: 0,right: 0))
        }
    }
    func hideProgressHUD() {
        if let hub = self.hub {
            hub.activityView.stopAnimating()
            hub.removeFromSuperview()
        }
    }
}