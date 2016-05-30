//
//  Refresh.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/14.
//  Copyright © 2016年 王亚军. All rights reserved.
//
import MJRefresh
import UIKit
extension UIScrollView {
    
    typealias refreshFooder = (Void -> Void)
    
    func addHeaderWithCallback(header:refreshFooder) {
        
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: header)
        
//        let refreshHeader = MJRefreshNormalHeader()
//        refreshHeader.refreshingBlock =  header
//        self.mj_header = refreshHeader
    }
    func headerEndRefreshing() {
        self.mj_header.endRefreshing()
    }
    func addFooterWithCallback(footer:refreshFooder) {
        
//        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//        // 设置了底部inset
//        self.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//        // 忽略掉底部inset
//        self.mj_footer.ignoredScrollViewContentInsetBottom = 30;
//        self.fooder = fooder;
        
        self.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self,refreshingAction: sel_getUid("loadMoreData"))

//        self.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
//        self.mj_footer.ignoredScrollViewContentInsetBottom = 30
        let loadCall = MJfooderCallBack()
        loadCall.callback = footer
        self.fooder = loadCall
    }
    func footerEndRefreshing() {
        self.mj_footer.endRefreshing()
    }
    func loadMoreData() {
        if self.fooder != nil {
           self.fooder?.callback();
        }
    }
    var footerHidden:Bool {
        get{
            return false
        }
        set {
           self.mj_footer.hidden = newValue;
        }
    }
    private struct Refresh {
        static var fooder:MJfooderCallBack?
    }
    
    var fooder:MJfooderCallBack? {
        get {
            return objc_getAssociatedObject(self, &Refresh.fooder) as? MJfooderCallBack
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &Refresh.fooder, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

class MJfooderCallBack: NSObject {
    var  callback:((Void)->Void)!
}