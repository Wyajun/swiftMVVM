//
//  NoticeMgr.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
///  后台切换至前台操作
private let KSYSAPPBECOMEACTIVE = "sysappBecomeActive"

func  appBecomeActive(lifeCycle:AnyObject,action:(Void)->Void) {
    let notice = NoticeBlock()
    notice.block = action
     NoticeMgr.sharedInstance.setActionKey(KSYSAPPBECOMEACTIVE, key: lifeCycle, block: notice)
}

///  前台进入后台操作
private let KSYSAPPEnterBackground = "KSYSAPPEnterBackground"

func appEnterBackground(lifeCycle:AnyObject,action:(Void)->Void) {
    let notice = NoticeBlock()
    notice.block = action
    NoticeMgr.sharedInstance.setActionKey(KSYSAPPEnterBackground, key: lifeCycle, block: notice)
}

extension NoticeMgr {
    func appEnterBackground() {
        NoticeMgr.sharedInstance.runBlock(KSYSAPPEnterBackground, parame: nil)
    }
    
    func appBecomeActive() {
         NoticeMgr.sharedInstance.runBlock(KSYSAPPBECOMEACTIVE, parame: nil)
    }
    
}

private class NoticeMgr {

    var launchOptions:NSDictionary!
    var isLaunch:Bool!
    var isallow:Bool!
    var isActive:Bool! // 程序是否在前台
    var actionDic:NSMutableDictionary!
    var bindqueue:dispatch_queue_t!
    static let sharedInstance: NoticeMgr = {
        return NoticeMgr()
    }()
    
    private  init(){
        launchOptions = NSDictionary()
        isLaunch = false
        isallow = false
        isActive = false
        actionDic = NSMutableDictionary()
        bindqueue  =  dispatch_queue_create("SystemManagerQueue", DISPATCH_QUEUE_CONCURRENT)
    }
    
    func registerSystemNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel_getUid("appEnterBackground"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: sel_getUid("appBecomeActive"), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func setActionKey(actionKey:String,key:AnyObject,block:NoticeBlock) {
        var  mapTable = actionDic[actionKey] as? NSMapTable
        if mapTable == nil {
            mapTable = NSMapTable(keyOptions: NSMapTableWeakMemory,valueOptions:NSMapTableStrongMemory )
            actionDic[actionKey] = mapTable
        }
        mapTable?.setObject(block, forKey: key)
    }
    func runBlock(key:String,parame:AnyObject?) {
        let mapTable = actionDic[key]
        if mapTable == nil {
            return
        }
        let enumerator = mapTable?.objectEnumerator()
        
        while let obj = enumerator!.nextObject()  {
            let obj1 = obj  as! NoticeBlock
            if parame == nil {
                obj1.block()
            }else {
                obj1.blockObj(parame!)
            }
        }
    }
}
class  NoticeBlock {
    var block:((Void)->Void)!
    var blockObj:((AnyObject)->Void)!
}
