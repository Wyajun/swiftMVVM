//
//  JDTimer.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/29.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
class JDTimer:NSObject {
    let source:dispatch_source_t
    var suspended:Bool
    
    static func timerWithInterval(interval:UInt64,leeway:UInt64,queue:dispatch_queue_t,block:dispatch_block_t)->JDTimer{
        return JDTimer(interval: interval, leeway: leeway, queue: queue, block: block)
    }
    
    static func timerWithStart(start:Int64,leeway:UInt64,queue:dispatch_queue_t,block:dispatch_block_t)->JDTimer {
        return JDTimer(start: start, leeway: leeway, queue: queue, block: block)
    }
    
    init(interval:UInt64,leeway:UInt64,queue:dispatch_queue_t,block:dispatch_block_t) {
        source =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.source,dispatch_walltime(nil, 0),interval,leeway);
        dispatch_source_set_event_handler(self.source, block);
        suspended = true
    }
    init(start:Int64,leeway:UInt64,queue:dispatch_queue_t,block:dispatch_block_t){
         self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.source, dispatch_walltime(nil, start), DISPATCH_TIME_FOREVER, leeway);
        dispatch_source_set_event_handler(self.source, block);
        suspended = true
    }
    
    deinit {
        resume()
    }
    func resume() {
        guard suspended else {
            return
        }
        dispatch_resume(self.source);
        self.suspended = false;
    }
    
    func suspend() {
     if suspended {
        return;
        }
    dispatch_suspend(self.source);
    self.suspended = true;
    }
    
    func cancel() {
    dispatch_source_cancel(self.source);
    }
  
}