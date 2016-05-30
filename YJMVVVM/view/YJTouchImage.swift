//
//  YJTouchImage.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/19.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class YJTouchImage: UIImageView {
    var touchBlock:((Void)->Void)!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchBlock != nil {
            touchBlock()
        }
    }
}
