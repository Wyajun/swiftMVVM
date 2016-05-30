//
//  YJBaseModelProtocol.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
protocol YJBaseModelProtocol {
    
    func sendNetworkRequest(callback: ((httpCode: HttpCodeStatus) -> Void))
}

extension YJBaseModelProtocol {
    
    func sendNetworkRequest(callback: ((httpCode: HttpCodeStatus) -> Void)) {
        
    }
}

class BaseModel:YJBaseModelProtocol {
    
}

