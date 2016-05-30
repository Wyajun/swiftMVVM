//
//  ViewEmpty.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/9.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit
extension UIView {
    
    private struct EmptyView {
        static var emptyView:UIView?
    }
    var emptyView:UIView? {
        get {
            return objc_getAssociatedObject(self, &EmptyView.emptyView) as? UIView
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &EmptyView.emptyView, value as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    func showEmptyView() {
        ViewEmpty.showEmptyView(self)
    }
    func hiddenEmptyView() {
        ViewEmpty.hiddenEmptyView(self)
    }
}
class ViewEmpty: UIView {
    class  func showEmptyView(showInView:UIView) {
        if let empty = showInView.emptyView {
            empty.hidden = false
            return
        }
       let emptyView = ViewEmpty(viewClass: showInView)
    
       if (showInView is UITableView || showInView is UICollectionView ) && showInView.subviews.count > 1 {
           showInView.insertSubview(emptyView, atIndex: 1)
       }else {
        showInView.addSubview(emptyView)
       }
       emptyView.snp_makeConstraints { (make) -> Void in
        make.center.equalTo(0)
       }
        showInView.emptyView = emptyView
    }
    
    class func hiddenEmptyView(showInView:UIView) {
        showInView.emptyView?.hidden = true
    }
    
    init(viewClass:UIView) {
        super.init(frame: CGRectZero)
        self.userInteractionEnabled = false;
        self.creatShowEmptykView(viewClass)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func creatShowEmptykView(viewClass:UIView) {
        
        let imageName = "JDKonBaiYe"
        let emptyView = UIImageView()
        emptyView.image = Resource.imageName(imageName)
        self.addSubview(emptyView)
        emptyView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
            make.edges.equalTo(UIEdgeInsetsZero)
        }
    }
}