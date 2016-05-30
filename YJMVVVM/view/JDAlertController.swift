//
//  JDAlertController.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/8.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
class JDAlertController :NSObject{
    static func alterWithTitle(title:String?,message:String?,cancelButtonTitle:String,otherButtonTitle:String?,selectIndex:((selectIndex:Int)->Void)) {
        let alter = UIAlertController.init(title: title, message: message, preferredStyle: .Alert);
        if (cancelButtonTitle.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler: { (alter1) -> Void in
                selectIndex(selectIndex: 0)
            })
            
            alter.addAction(cancelAction)
        }
        if let otherTitle = otherButtonTitle {
            let otherAction = UIAlertAction(title: otherTitle, style: .Default, handler: { (alter1
                ) -> Void in
                selectIndex(selectIndex: 1)
            })
            alter.addAction(otherAction)
        }
        
        currentViewController().presentViewController(alter, animated: true, completion: nil)
    }
    static func sheetWithTitle(title:String?,cancelButtonTitle:String,otherButtonTitles:[String],selectIndex:((selectIndex:Int)->Void)) {
        let alter = UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { (alter1) -> Void in
            
            if otherButtonTitles.count > 0 {
                selectIndex(selectIndex: otherButtonTitles.count)
            }else {
                 selectIndex(selectIndex: 0)
            }
        }
        alter.addAction(cancelAction)
        
        var  index:Int = 0;
        for  title in otherButtonTitles {
            let  index1 = index
            let otherAction = UIAlertAction(title: title, style: .Default, handler: { (alter1) -> Void in
                selectIndex(selectIndex: index1)
            })
            alter.addAction(otherAction)
            index+=1;
        }
        currentViewController().presentViewController(alter, animated: true, completion: nil)
    }
   
}