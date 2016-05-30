//
//  KeyBoardView.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView :UIGestureRecognizerDelegate{
    private struct editViewKeyBoard {
        static var editView:UIView?
    }
    
    private struct jianPanTanQiKeyBoard {
        static var jianPanTanQi:Bool?
    }
    
    private struct KeyBoardView {
        static var keyBoardView:UIView?
    }
    
    var editView:UIView? {
        get {
            return objc_getAssociatedObject(self, &editViewKeyBoard.editView) as? UIView
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &editViewKeyBoard.editView, value as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var jianPanTanQi:Bool? {
        get {
            return objc_getAssociatedObject(self, &jianPanTanQiKeyBoard.jianPanTanQi) as? Bool
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &jianPanTanQiKeyBoard.jianPanTanQi, value as Bool?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }

    }
    
    var keyBoardView:UIView? {
        get {
            return objc_getAssociatedObject(self, &KeyBoardView.keyBoardView) as? UIView
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &KeyBoardView.keyBoardView, value as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }

    }
    
    private  func addKeyBoardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel_getUid("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel_getUid("keyboardWillHidden:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer.init(target: self, action: sel_getUid("tapPress"))
        self.addGestureRecognizer(tap)
        tap.delegate = self
    }
    override public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pq = jianPanTanQi {
            return pq
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }

    
    
    func keyboardWillHidden(notification:NSNotification) {
        self.tapPress( )
    }
    func keyboardWillShow(notification:NSNotification) {
        jianPanTanQi = true
        guard let  edView = self.editView else {
            return
        }
        let info = notification.userInfo
        let kbsize = info![UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size
        self.keyBoardView!.snp_updateConstraints { (make) -> Void in
            make.height.equalTo((kbsize?.height)!)
        }
        let frame = edView.convertRect((edView.bounds), fromView: self)
        var offset = frame.size.height + frame.origin.y
        offset -= self.contentOffset.y
        let height = kScreenHeight - kbsize!.height
        if offset > height {
            let offsetY = offset - height + self.contentOffset.y
            self.contentOffset = CGPointMake(0.0, offsetY)
        }
    }
    func tapPress() {
        jianPanTanQi = false;
        self.endEditing(false)
        self.keyBoardView!.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(0);
        }
    }
    
    func registeredKeyboardNotification() {
        addKeyBoardNotification()
        self.keyBoardView = UIView()
        self.superview!.addSubview(keyBoardView!)
        self.keyBoardView!.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(0)
        }
        self.jianPanTanQi = false
        self.snp_remakeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(self.keyBoardView!.snp_top)
        }
    }
}