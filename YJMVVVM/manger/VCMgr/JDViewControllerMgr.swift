//
//  JDViewControllerMgr.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/4.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit

func popViewController(animated:Bool) {
    JDViewControllerMgr.sharedInstance.popViewController(true)
}



func currentViewController()->UIViewController {
   return  JDViewControllerMgr.sharedInstance.mostAppropriateControllerView()!
}

func dismissViewController(viewController:UIViewController,animated:Bool) {
    JDViewControllerMgr.sharedInstance.dismissViewController(viewController, animated: animated)
}


func tabbarView() -> UIView {
   return (JDViewControllerMgr.sharedInstance.tab?.view)!
}

private class JDViewControllerMgr {
     let Wnav : JDNaviGator
     var tab:UITabBarController?
    static let sharedInstance: JDViewControllerMgr = {
        return JDViewControllerMgr()
    }()
    
      init() {
        Wnav = JDNaviGator()
        self.tab = UIApplication.sharedApplication().keyWindow?.rootViewController as? UITabBarController
    }
    
    func pushViewController(vcid:String,parame:AnyObject?){
        Wnav.pushViewController(vcid, parame: parame, pushVc: navigationController()!)
    }
    
    func popViewController(animated:Bool){
        Wnav.popViewController(mostAppropriateControllerView()!)
    }
    
    func  presentViewController(vcid:String,parame:AnyObject?,isNav:Bool) {
        Wnav.presentViewController(vcid, parame: parame, presentVc: mostAppropriateControllerView()!, isNav: isNav)
    }
    func dismissViewController(viewController:UIViewController,animated:Bool) {
        Wnav.dismissViewController(viewController, animated: animated)
    }
    func mostAppropriateControllerView()->UIViewController? {
        // 如果根控制器不是——tab证明为初始化完成。返回空
        if  let tab_  = tab {
            // 当前保存的和——tab的选择的相同 则一定是——
            let tabNav = tab_.selectedViewController as! UINavigationController
            if ( self.Wnav.currentViewController == tabNav.topViewController) {
                return self.Wnav.currentViewController;
            }
            // 模态视图则返回这个
            if self.Wnav.currentViewController.presentingViewController != nil {
                return self.Wnav.currentViewController
            }
            // 这种情况出现在，tab切换但是Wnav.currentViewController还是保存旧的情况
            return tabNav.topViewController;
        }
        return Wnav.currentViewController
    }
    func navigationController()->UINavigationController? {
        var vc = mostAppropriateControllerView()
        
        if vc == nil {
            vc  = self.Wnav.currentViewController
        }
        if let n = vc {
            if n is UINavigationController {
                return n as? UINavigationController
            }
            if  n is UITabBarController {
                let tab1:UITabBarController = n as! UITabBarController
                return tab1.selectedViewController as? UINavigationController
            }
        }
        
        if let navc = vc?.navigationController  {
            return navc
        }
        
        return nil
    }
}


