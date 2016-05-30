//
//  const.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/23.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import UIKit

let kSignKey = "MhxzKhl@jiadao.cn"
let kJDBASEURL = "http://api.wdtfw.com/"
let kScreenWidth =  UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height


let kViewStartX:Float  = 15.0
let kViewSpace :Float  =  10.0
let KViewHeigth2:Float = 55.0
let kViewHeigth1:Float = 48.0
let KViewHeader :Float = 30.0
let KViewCornerRadius:Float = 4.0
let KButHeight:Float  = 40.0


func KJDBASEURLAPPEND(url:String)->String {return kJDBASEURL + url}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func KbuttonDefaultSet(bnt:UIButton){
    bnt.backgroundColor = UIColor.systemWenZiHeader3()
    bnt.titleLabel!.font = UIFont.systemFontOfBntFont()
    bnt.layer.cornerRadius = CGFloat( KViewCornerRadius)
    bnt.clipsToBounds = true
}

// Mark 分割线

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

func anyObjectToInt(obj:AnyObject?,defaultValue:Int = 0) ->Int {
    
    guard obj != nil else{
        return defaultValue
    }
    
    if obj is Int {
        return obj as! Int
    }
    if obj is String {
        return Int(obj as! String)!
    }
    return defaultValue
}
func anyObjectToString(obj:AnyObject?,defaultValue:String = "" )->String {
   
    guard obj != nil else{
        return defaultValue
    }
    
    if obj is Int {
        return "\(obj)"
    }
    if obj is String {
        return obj as! String
    }
    return defaultValue
}




