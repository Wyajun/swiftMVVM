//
//  CreatLab.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/8.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
func creatLabWenZiHeader1(font:CGFloat,content:String = "")->UILabel {
    return creatLab(content, font: UIFont.systemFontOfSize(font), titleColor: UIColor.systemWenZiHeader1())
}
func creatLabWenZiHeader2(font:CGFloat,content:String = "")->UILabel {
    return creatLab(content, font: UIFont.systemFontOfSize(font), titleColor: UIColor.systemWenZiHeader1())
}
func creatLabWenZiHeader3(font:CGFloat,content:String = "")->UILabel {
    return creatLab(content, font: UIFont.systemFontOfSize(font), titleColor: UIColor.systemWenZiHeader1())
}
func creatLabWenZiHeader4(font:CGFloat,content:String = "")->UILabel {
    return creatLab(content, font: UIFont.systemFontOfSize(font), titleColor: UIColor.systemWenZiHeader1())
}

func creatLab(title:String,font:UIFont,titleColor:UIColor)->UILabel {
    let lab = UILabel()
    lab.text = title
    lab.textColor = titleColor
    lab.font = font
    return lab
}
