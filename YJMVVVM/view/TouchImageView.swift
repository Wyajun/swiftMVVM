//
//  TouchImageView.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/7.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class TouchImageView: UIImageView {
    var tapBlock:(()->Void)?
    override init(frame: CGRect) {
         tapBlock = nil
         super.init(frame: frame)
        self.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: "tapButPress:")
        self.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tapButPress(tap:UITapGestureRecognizer) {
        if let block = tapBlock {
            block()
        }
    }
    
}
