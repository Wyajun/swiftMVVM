//
//  JDAutoLayoutScrollView.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/24.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import UIKit
import SnapKit
enum AuotLayoutScrollerViewType:Int {
    // 垂直方向
   case AuotLayoutScrollerViewType_V = 1
    // 水平方向
   case AuotLayoutScrollerViewType_H = 2
};
class JDAutoLayoutScrollView: UIScrollView {
    
    var type:AuotLayoutScrollerViewType?
    var Constraint_:NSLayoutConstraint?
    weak var LastView:UIView?
    weak var contentView:UIView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let content = UIView()
        self.addSubview(content)
        content.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(EdgeInsetsZero)
        }
        contentView = content
    }
    init(frame:CGRect,auotLayoutType:AuotLayoutScrollerViewType){
        super.init(frame: frame)
        self.setContentSize(frame.size, auotLayoutType: auotLayoutType)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setContentSize(size:CGSize,auotLayoutType:AuotLayoutScrollerViewType) {
        type = auotLayoutType
        switch auotLayoutType {
        case .AuotLayoutScrollerViewType_H:
             contentView?.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(size.height)
             })
        case .AuotLayoutScrollerViewType_V:
            contentView?.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(size.width)
            })
        }
    }
    func addAuotLayoutView_V(view:UIView,height:Float) {
        assert(type! == .AuotLayoutScrollerViewType_V,"scrollview为垂直方向添加view才能调用此方法")
        contentView?.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        if let last = LastView {
            
            contentView?.removeConstraint(Constraint_!)
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(last.snp_bottom)
                if height > 0 {
                    make.height.equalTo(height)
                }
            })
            
            LastView = view
        }else {
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(0)
                if height > 0 {
                    make.height.equalTo(height)
                }
            })
            LastView = view
        }
        Constraint_ = NSLayoutConstraint(item: contentView!, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute:.Bottom , multiplier: 1, constant: 0)
        contentView?.addConstraint(Constraint_!)
    }
    func addAuotLayoutView_H(view:UIView,width:Float) {
        assert(type! == .AuotLayoutScrollerViewType_H,"scrollview为垂直方向添加view才能调用此方法")
        contentView?.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        if let last = LastView {
            contentView?.removeConstraint(Constraint_!)
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(last.snp_right)
                make.height.equalTo(width)
            })
            LastView = view
        }else {
            view.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(0)
                make.height.equalTo(width)
            })
            LastView = view
        }
        Constraint_ = NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute:.Right , multiplier: 1, constant: 0)
        contentView?.addConstraint(Constraint_!)
    }
    func setAuotLayoutView(view:UIView,content:Float) {
        if type == .AuotLayoutScrollerViewType_V {
            view.snp_updateConstraints(closure: { (make) -> Void in
                make.width.equalTo(content)
            });
        }else {
            view.snp_updateConstraints(closure: { (make) -> Void in
                make.height.equalTo(content)
            })
        }
    }
    
}
/*
extension UIView {
private struct AssociatedHeightKeys {
static var W_height:Float?
}
var W_height:Float? {
get {
return objc_getAssociatedObject(self, &AssociatedHeightKeys.W_height) as? Float
}
set {
if let newValue = newValue {
objc_setAssociatedObject(self, &AssociatedHeightKeys.W_height, newValue as Float?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}
}
}
private struct AssociatedConstraintKeys {
static var Constraint:ConstraintDescriptionEditable?
}
var Constraint:ConstraintDescriptionEditable? {
get {
return objc_getAssociatedObject(self, &AssociatedConstraintKeys.Constraint) as? ConstraintDescriptionEditable
}
set {
if let newValue = newValue {
objc_setAssociatedObject(self, &AssociatedConstraintKeys.Constraint, newValue as ConstraintDescriptionEditable?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}
}
}
}
*/
