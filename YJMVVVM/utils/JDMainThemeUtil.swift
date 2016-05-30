//
//  JDMainThemeUtil.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
class JDMainThemeUtil {
    static func themeAppearence() {
        //Navgation字体颜色
        let titleColor = UIColor.systemWenZiHeader1();
        let shadow = NSShadow();
        shadow.shadowColor = UIColor.clearColor();
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: titleColor,
            NSShadowAttributeName: shadow,
            NSFontAttributeName: UIFont.systemFontOfText5Font()]
        
        //Navgation背景颜色
        UINavigationBar.appearance().barTintColor = UIColor.systemViewBackgroundColor1()
    }
}