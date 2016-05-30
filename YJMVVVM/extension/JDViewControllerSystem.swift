//
//  JDViewControllerSystem.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/4.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit
import Foundation
extension UIViewController {
    
    func defaultVCSetting() {
        showDefaultLeftButton()
        self.view.backgroundColor = UIColor.systemViewBackgroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    func rightBarButtonPressed(right:UIButton){
        
    }
    func leftBarButtonPressed(left:UIButton) {
        popViewController(true)
    }
    
    func createButtonWithTitle(title:String)->UIButton {
        let button = UIButton.init(frame: CGRectMake(0, 0, 100, 44))
        button.setTitle(title ,forState:.Normal);
        button.titleLabel?.font =  UIFont.systemFontOfBntFont();
        let attributes = [NSFontAttributeName: button.titleLabel!.font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let  size =  title.boundingRectWithSize(CGSizeMake(200, 300), options: option, attributes: attributes, context: nil)
        button.frame = CGRectMake(0, 0, size.width, 44);
        return button;
    }
    func showRightButtonWithTitle(title:String) {
        let button =  createButtonWithTitle(title)
        button.setTitleColor(UIColor.systemZhuTiSe(), forState:.Normal);
        let barItem = UIBarButtonItem.init(customView: button)
        button.addTarget(self, action: "rightBarButtonPressed:", forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = barItem;
    }
    func showRightButtonWithImage(image:UIImage,high:UIImage?) {
        
        let  button = UIButton.init(frame: CGRectMake(0, 0, 44, 44))
        let marginX = image.size.width < 44 ? (44 - image.size.width) / 2 : 0;
        let marginY = image.size.height < 44 ? (44 - image.size.height) / 2 : 0;
        button.imageEdgeInsets = UIEdgeInsetsMake(marginY, marginX * 2, marginY, 0);
        button.setImage(image ,forState:.Normal)
        if let himage = high {
             button.setImage(himage ,forState:.Highlighted)
        }
        
        let barItem = UIBarButtonItem.init(customView: button)
        button.addTarget(self, action: "rightBarButtonPressed:", forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = barItem;
    }
    func showLeftButtonWithTitle(title:String) {
        let button =  createButtonWithTitle(title)
        button.setTitleColor(UIColorFromRGB(0x6c6c6c), forState: .Normal)
        let barItem = UIBarButtonItem.init(customView: button)
        button.addTarget(self, action: "leftBarButtonPressed:", forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = barItem;
    }
    func showLeftButtonWithImage(image:UIImage,high:UIImage?) {
        let  button = UIButton.init(frame: CGRectMake(0, 0, 44, 44))
        let marginX = image.size.width < 44 ? (44 - image.size.width) / 2 : 0;
        let marginY = image.size.height < 44 ? (44 - image.size.height) / 2 : 0;
        button.imageEdgeInsets = UIEdgeInsetsMake(marginY, 0, marginY, marginX * 2);
        button.setImage(image ,forState:.Normal)
        if let himage = high {
            button.setImage(himage ,forState:.Highlighted)
        }
        
        let barItem = UIBarButtonItem.init(customView: button)
        button.addTarget(self, action: "leftBarButtonPressed:", forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = barItem;
    }
    func customLeftButton()->UIButton? {
        let backButton = self.navigationItem.leftBarButtonItem!.customView
        if  backButton is UIButton {
            return backButton as? UIButton;
        }
        return nil
    }
    func customRightButton()->UIButton? {
        let backButton = self.navigationItem.rightBarButtonItem!.customView
        if  backButton is UIButton {
            return backButton as? UIButton;
        }
        return nil
    }
    func showDefaultLeftButton() {
        if self.navigationController?.viewControllers.count > 1 {
        showLeftButtonWithImage(Resource.imageName("title_backarrow"), high: nil)
        }
    }
    
}

extension UIViewController {
    private struct parameKeys {
        static var parame:AnyObject?
    }
    var parame:AnyObject? {
        get {
            return objc_getAssociatedObject(self, &parameKeys.parame) 
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &parameKeys.parame,value  as AnyObject?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
