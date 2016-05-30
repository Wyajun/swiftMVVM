//
//  YJBaseViewControllerProtocol.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
protocol YJBaseViewControllerProtocol {
    var vcModel : BaseModel! {get}
    var vcView : BaseView! {get}
}



extension YJBaseViewControllerProtocol where Self:UIViewController {
    var vcModel:BaseModel! {
        return nil
    }
    
    var vcView:BaseView! {
        return nil
    }
}

extension UIViewController :YJBaseViewControllerProtocol{
    
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultVCSetting()
        bindModelAndVc()
        
    }
    func bindModelAndVc() {
        
        self.view.addSubview(self.vcView)
        self.vcView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            if self.hidesBottomBarWhenPushed {
                make.bottom.equalTo(self.snp_bottomLayoutGuideBottom)
            }else {
                make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
            }
        }
        self.vcView.viewModel = self.vcModel
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.vcView.refreshView()
    }

}