//
//  TTouchView.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/5/9.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit


class TTouchView: UIControl {
    typealias touchBlock = ()->Void
    var touch:touchBlock!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: sel_getUid("touchPress"), forControlEvents: .TouchUpInside)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func touchPress() {
        guard let t = touch else {
            return
        }
        t()
    }
}
