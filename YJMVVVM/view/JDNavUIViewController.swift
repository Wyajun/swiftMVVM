//
//  JDNavUIViewController.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/6.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class JDNavUIViewController: UINavigationController,UIGestureRecognizerDelegate {
    override func viewDidLoad() {
         super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer {
            return self.viewControllers.count > 1
        }
        return false
    }
}
