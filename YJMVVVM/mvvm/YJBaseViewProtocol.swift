//
//  YJBaseViewProtocol.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
protocol YJBaseViewProtocol {
    var baseModel:YJBaseModelProtocol! {get set}
    /// 创建初始化view
    func initCustomView()
    /// 刷新view
    func refreshView()
    
}

extension YJBaseViewProtocol where Self:UIView {
    
    var baseModel:YJBaseModelProtocol! {
        get {
            return nil
        }
        set {
            
        }
    }
    
    func initCustomView() {
        
    }
    
    func refreshView() {
        
    }
    
}

extension UIView: YJBaseViewProtocol {
    
    func repeatOrderList() {
        showProgressHUD()
        baseModel.sendNetworkRequest { [weak self] (success) -> Void in
            if let strong = self {
                strong.hideProgressHUD()
                if success == .success {
                    strong.hiddenErrorView()
                    strong.initCustomView()
                }else {
                    strong.hiddenEmptyView()
                    strong.showErrorView(){
                        strong.repeatOrderList()
                    }
                }
            }
        }
        
    }
}

class BaseView: UIView {
    private var baseModel:YJBaseModelProtocol!
    var refreshCount:Int
    override init(frame: CGRect) {
        refreshCount = 0
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel:YJBaseModelProtocol! {
        get {
            return baseModel
        }
        set {
            baseModel = newValue
            repeatOrderList()
        }
    }
}
