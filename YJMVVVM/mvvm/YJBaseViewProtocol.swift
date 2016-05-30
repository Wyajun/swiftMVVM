//
//  YJBaseViewProtocol.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation

protocol YJBaseViewProtocol {
    var baseModel:YJBaseModelProtocol {get}
    /// 创建初始化view
    func initCustomView()
    /// 刷新view
    func refreshView()
}
