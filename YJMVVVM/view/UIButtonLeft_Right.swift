//
//  UIButtonLeft_Right.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/6.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class UIButtonLeft_Right: UIButton {
    var startImageX:CGFloat; // 距离左侧的间距
    var SpaceTitle:CGFloat; // 图片与文字之间的间距
    var buttonHeight:CGFloat;// 文字的高度
    override init(frame: CGRect) {
        startImageX = 0.0;
        SpaceTitle = 0.0
        buttonHeight = 0.0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let image =  self.imageForState(.Normal)!;
        let titleX = image.size.width + startImageX + SpaceTitle;
        let titleWidth = self.bounds.size.width - titleX;
        if(buttonHeight < 7) {
            buttonHeight = self.bounds.size.height;
        }
        return CGRectMake(titleX, (self.bounds.size.height - buttonHeight)/2, titleWidth,buttonHeight);
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let image =  self.imageForState(.Normal)!;
        return CGRectMake(startImageX, (self.bounds.size.height - image.size.height)/2, image.size.width, image.size.height);
    }
    
}
