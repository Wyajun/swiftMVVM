//
//  UIColorSystem.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/24.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    /// 0x00aaef
    static func systemZhuTiSe ()->UIColor{
      return UIColorFromRGB(0x00aaef);
    }
    /// 0x333333
    static func systemWenZiHeader1()->UIColor {
    return UIColorFromRGB(0x333333);
    }
    /// 0x666666
    static func systemWenZiHeader2 ()->UIColor{
    return UIColorFromRGB(0x666666);
    }
    /// 0xf49c2d
    static func systemWenZiHeader3 ()->UIColor{
        return UIColorFromRGB(0xf49c2d);
    }
    /// 0xdfdfdf
    static func systemFGX()->UIColor {
    return UIColorFromRGB(0xdfdfdf);
    }
    /// 0xf9f9f9
    static func systemViewBackgroundColor()->UIColor {
    return UIColorFromRGB(0xf9f9f9);
    }
    static func systemTimeColor()->UIColor {
        return UIColorFromRGB(0xfefefe);
    }
    /// 0xffffff
    static func systemViewBackgroundColor1 ()->UIColor{
    return UIColorFromRGB(0xffffff);
    }
    /// 0x999999
    static func systemWenZiHeader4()->UIColor {
    return UIColorFromRGB(0x999999);
    }
    /// 0xde554c
    static func systemButtonColor1()->UIColor {
    return UIColorFromRGB(0xde554c);
    }
    static func imageWithColor(color:UIColor)->UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}