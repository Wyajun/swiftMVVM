//
//  File.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/28.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
class JDUtil {
    static func checkCellphone(cellphone:String)->Bool {
        let Regex = "(1[0-9])\\d{9}"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", Regex)
        return mobileTest.evaluateWithObject(cellphone)
    }
    
    static func checkPassWord(passwd:String)->Bool {
        let regex = "(^[A-Za-z0-9]{6,16}$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex);
        return pred.evaluateWithObject(passwd);
    }
    
}


