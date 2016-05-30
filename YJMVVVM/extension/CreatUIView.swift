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
func creatZhuTiSheButton()->UIButton {
     let bnt = UIButton()
    KbuttonDefaultSet(bnt)
    return bnt
}
func KbuttonDefaultSet(bnt:UIButton){
    bnt.backgroundColor = UIColor.systemWenZiHeader3()
    bnt.titleLabel!.font = UIFont.systemFontOfBntFont()
    bnt.layer.cornerRadius = CGFloat( KViewCornerRadius)
    bnt.clipsToBounds = true
}

func KTopFGX(backView:UIView)->UIView {
    return KTopOffsetFGX(backView, topOffset: 0)
}

func KTopStartxFGX(backView:UIView)->UIView {
    return KTopStartxOffsetFGX(backView,topOffset: 0, startx: Float( kViewStartX))
}

func KTopOffsetFGX(backView:UIView,topOffset:Float)->UIView {
    return  KTopStartxOffsetFGX(backView, topOffset: topOffset, startx: 0)
}

func KTopStartxOffsetFGX(backView:UIView,topOffset:Float,startx:Float)->UIView {
    let  viewname = UIView()
    backView.addSubview(viewname)
    viewname.backgroundColor = UIColor.systemFGX()
    viewname.snp_makeConstraints { (make) -> Void in
        make.top.equalTo(topOffset)
        make.left.equalTo(startx)
        make.right.equalTo(0)
        make.height.equalTo(0.5)
    }
    return viewname
}

func KBottomFGX(backView:UIView)->UIView {
    return  KBottomStartxOffsetFGX(backView, startx: 0)
}

func KBottomStartxOffsetFGX(backView:UIView,startx:Float)->UIView {
    let  viewname = UIView()
    backView.addSubview(viewname)
    viewname.backgroundColor = UIColor.systemFGX()
    viewname.snp_makeConstraints { (make) -> Void in
        make.bottom.equalTo(0)
        make.left.equalTo(startx)
        make.right.equalTo(0)
        make.height.equalTo(0.5)
    }
    return viewname
}



