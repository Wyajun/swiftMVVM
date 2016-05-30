//
//  JDThread.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/29.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation


func  SynchronizedLock(lock:AnyObject,f:()->()) {
    objc_sync_enter(lock)
    f()
    objc_sync_exit(lock)
}


func runInMain(f:()->()) {
    dispatch_async(dispatch_get_main_queue()) {
        f()
    }
}


func afterSecRun(sce:Float,f:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(sce * Float( NSEC_PER_SEC)));
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        f()
    }
}


