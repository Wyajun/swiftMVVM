//
//  ViewError.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/9.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit
extension UIView {
    private struct ErrorView {
        static var errorView:UIView?
    }
    var errorView:UIView? {
        get {
            return objc_getAssociatedObject(self, &ErrorView.errorView) as? UIView
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &ErrorView.errorView, value as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func showErrorView(callback:(Void ->Void)) {
        ViewError.showErrorView(self, callback: callback)
    }
    func hiddenErrorView() {
        ViewError.hideErrorView(self)
    }
}

class ViewError: UIControl {
    class func showErrorView(showInView:UIView,callback:(Void ->Void)) {
        if let errorView = showInView.errorView {
            errorView.hidden = false
            return
        }
        let errorView = ViewError()
        errorView.clickBlock = callback
        showInView.addSubview(errorView)
        errorView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
        showInView.errorView = errorView
        
    }
    class func hideErrorView(showInView:UIView) {
        if let errorView = showInView.errorView {
            errorView.hidden = true
        }
    }

    var clickBlock:(Void -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:sel_getUid("clickPress") , forControlEvents: .TouchUpInside)
        self.creatErrorView()
    }
    func creatErrorView() {
        let backView = UIView()
        self.addSubview(backView)
        backView.userInteractionEnabled = false
        backView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
        
        
        let  errorImg = UIImageView();
        errorImg.userInteractionEnabled = false
        errorImg.image = Resource.imageName("JDWuWangLuo")
        self.addSubview(errorImg)
        errorImg.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func clickPress() {
        if let click = clickBlock {
            click()
        }
    }
    
}
