//
//  UIButtonUp_down.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/6.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class UIButtonUp_down: UIButton {
    var startImageY:CGFloat  // 距离顶部的间距
    var SpaceTitle:CGFloat // 图片与文字之间的间距
    var buttonHeight:CGFloat // 文字的高度
    override init(frame: CGRect) {
        startImageY = 0.0;
        SpaceTitle = 0.0
        buttonHeight = 0.0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let image:UIImage!  = self.imageForState(.Normal)
        let titleY = image.size.height + startImageY + SpaceTitle
        var titleHeight = self.bounds.size.height - titleY
        if buttonHeight > 5 {
            titleHeight = buttonHeight;
        }
        return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight)
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
         let image =  self.imageForState(.Normal)!
        return CGRectMake((self.bounds.size.width-image.size.width)/2, startImageY, image.size.width, image.size.height);
    }
}
