//
//  JDNaviGator.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/4.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
class JDNaviGator {
    private weak var viewController: UIViewController?
    init () {
        viewController = nil
    }
    func pushViewController(vcid:String ,parame:AnyObject?,pushVc:UINavigationController) {
        pushViewController(vcid, parame: parame, animated: true,pushVc:pushVc)
    }
    func pushViewController(vcid:String ,parame:AnyObject?,animated:Bool,pushVc:UINavigationController) {
        let vcClass:AnyClass? = NSClassFromString(vcid)
        if  let cClass = vcClass as? UIViewController.Type {
            let vc = cClass.init()
            vc.parame = parame
            vc.hidesBottomBarWhenPushed = true
            pushVc.pushViewController(vc, animated: animated)
            viewController = vc
        }else {
          assert(false, "没有找到可以push控制器 ---\(vcid)")
        }
        
    }
    func popViewController(ViewController:UIViewController) {
        popViewController(ViewController, animated: true)
    }
    func popViewController(ViewController:UIViewController,animated:Bool){
        let nav = ViewController.navigationController!
        nav.popViewControllerAnimated(animated)
        self.viewController = nav.topViewController
    }
    func presentViewController(vcid:String,parame:AnyObject?,presentVc:UIViewController,isNav:Bool) {
       
        let vcClass:AnyClass? = NSClassFromString(vcid)
        if  let cClass = vcClass as? UIViewController.Type {
            let vc = cClass.init()
            vc.parame = parame
            
            if isNav {
                let nav = UINavigationController(rootViewController: vc)
                viewController = nav
                presentVc.presentViewController(nav, animated: true, completion: nil )
            }else {
                presentVc.presentViewController(vc, animated: true, completion: nil )
                viewController = vc
            }
            
        }else {
            assert(false, "没有找到可以push控制器 ---\(vcid)")
        }

    }
    func dismissViewController(viewController:UIViewController,animated:Bool) {
        self.viewController = viewController.presentingViewController;
        viewController.dismissViewControllerAnimated(animated, completion: nil)
    }
    
    var currentViewController:UIViewController {
        get {
            if let vc = viewController {
                return vc
            }else {
               return (UIApplication.sharedApplication().keyWindow?.rootViewController!)!
            }
        }
        
    }
}