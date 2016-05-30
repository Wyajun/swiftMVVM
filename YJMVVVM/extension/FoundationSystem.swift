//
//  FoundationSystem.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/27.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
extension String {
    func swiftRange(nsRange:NSRange)->Range<Index>? {
        
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
    var length:Int {
        get {
            return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }
    }
}

protocol SetValueKeyDic {
    func setValueKey(dictionary:[String:AnyObject])
}

extension NSObject : SetValueKeyDic{
    
    class func objectWithArray(keyValuesArray:[AnyObject]?)->[NSObject] {
        
        guard keyValuesArray != nil else {
            return []
        }
        
        var array = [NSObject]()
        for keyValue in keyValuesArray! {
            let obj = self.creatObj(keyValue as! [String:AnyObject])
            array.append(obj)
        }

        return array
    }
    
    class func  creatObj(dictionary:[String:AnyObject])->Self {
        let obj = self.init()
        obj.setValueKey(dictionary)
        return obj
    }
    
    func setValueKey(dictionary:[String:AnyObject]) {
        
    }
}


