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

func pushTChargeEnterpriseViewController(){
   JDViewControllerMgr.sharedInstance.pushViewController("TChargeEnterpriseViewController", parame: "2132132323232")
}
func pushTFreeEnterpriseViewController(){
    JDViewControllerMgr.sharedInstance.pushViewController("TFreeEnterpriseViewController", parame: "2132132323232")
}
func pushTInductionCashbackViewController(){
    JDViewControllerMgr.sharedInstance.pushViewController("TInductionCashbackViewController", parame: "2132132323232")
}
func pushTInterviewViewController(){
    JDViewControllerMgr.sharedInstance.pushViewController("TInterviewViewController", parame: "2132132323232")
}

func pushTCityListController(){
    JDViewControllerMgr.sharedInstance.pushViewController("TCityListController", parame: nil)
}

func pushTWorkDetailViewController(workID:String)  {
  JDViewControllerMgr.sharedInstance.pushViewController("TWorkDetailViewController", parame: workID)
}

func pushRegisteredViewController(isOther:Bool)  {
  JDViewControllerMgr.sharedInstance.pushViewController("RegisteredViewController", parame: isOther)
}

func pushPerfectInforViewController(parame:[String:String]) {
    JDViewControllerMgr.sharedInstance.pushViewController("JDPerfectInforViewController", parame: parame)
    
}
func  presentTCityListController() {
    JDViewControllerMgr.sharedInstance.presentViewController("TCityListController", parame: ["noSite":true], isNav: true)
}

func pushTApplyWorkViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TApplyWorkViewController", parame: nil)
    
}

func pushTCollectWorkViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TCollectWorkViewController", parame: nil)
    
}

func pushTChatViewController(chatModel:TChatModel)  {
    JDViewControllerMgr.sharedInstance.pushViewController("TChatViewController", parame: chatModel)
    
}

func pushTKeFuChatViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TKeFuChatViewController", parame: nil)
}

func pushTZiXunViewController() {
     JDViewControllerMgr.sharedInstance.pushViewController("TZiXunViewController", parame: nil)
}
func pushTHuoDonViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("THuoDonViewController", parame: nil)
}

func pushTZiXunDetailViewController(arid:JSWebData) {
    JDViewControllerMgr.sharedInstance.pushViewController("JsWebViewController", parame: arid)
}

func pushTSiXinViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TSiXinViewController", parame: nil)
}

func pushTTongZhiChatViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TTongZhiChatViewController", parame: nil)
}
func pushTFuJingViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TFuJingViewController", parame: nil)
}
func pushTLianXiRenViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TLianXiRenViewController", parame: nil)
}
func pushTSendFriendViewController(parame:String?)  {
     JDViewControllerMgr.sharedInstance.pushViewController("TSendFriendViewController", parame: parame)
}

func pushTFriendDetailViewController(freind:TFriendData) {
    JDViewControllerMgr.sharedInstance.pushViewController("TFriendDetailViewController", parame: freind)
}
func pushTUserInfoViewController() {
    JDViewControllerMgr.sharedInstance.pushViewController("TUserInfoViewController", parame: nil)
}

func pushTFriendPesonViewController(userId:String) {
    JDViewControllerMgr.sharedInstance.pushViewController("TFriendPesonViewController", parame: userId)
}
func pushTUserInfoEditTextViewController(editData:TUserInfoEditTextData) {
    JDViewControllerMgr.sharedInstance.pushViewController("TUserInfoEditTextViewController", parame: editData)
}

func pushTUserInfoEditSelectViewController(edit:TUserInfoEditSelectData) {
    JDViewControllerMgr.sharedInstance.pushViewController("TUserInfoEditSelectViewController", parame: edit)

}

func pushTOtherUserViewController(userId:String) {
     JDViewControllerMgr.sharedInstance.pushViewController("TOtherUserViewController", parame: userId)
}
func pushTSettingViewController() {
     JDViewControllerMgr.sharedInstance.pushViewController("TSettingViewController", parame: nil)
}

func presentLoginViewController(isother:Bool)  {
   JDViewControllerMgr.sharedInstance.presentViewController("JDLoginViewController", parame: isother, isNav: true)
}

func currentViewController()->UIViewController {
   return  JDViewControllerMgr.sharedInstance.mostAppropriateControllerView()!
}

func dismissViewController(viewController:UIViewController,animated:Bool) {
    JDViewControllerMgr.sharedInstance.dismissViewController(viewController, animated: animated)
}



func jmpUserVc()  {
    JDViewControllerMgr.sharedInstance.tab?.selectedIndex = 3
}

func jmpWork()  {
//    JDViewControllerMgr.sharedInstance.tab?.tabBar.hidden = false
    JDViewControllerMgr.sharedInstance.tab?.selectedIndex = 0
}

func tabbarView() -> UIView {
   return (JDViewControllerMgr.sharedInstance.tab?.view)!
}

private class JDViewControllerMgr {
     let Wnav : JDNaviGator
     var tab:JDTabbarController?
    static let sharedInstance: JDViewControllerMgr = {
        return JDViewControllerMgr()
    }()
    
      init() {
        Wnav = JDNaviGator()
        self.tab = UIApplication.sharedApplication().keyWindow?.rootViewController as? JDTabbarController
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


