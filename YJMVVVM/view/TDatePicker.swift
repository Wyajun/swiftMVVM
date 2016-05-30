//
//  TDatePicker.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/5/12.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
class TDatePicker: UIControl {
    var startDate:NSDate
    var selectDate:((NSDate)->Void)!
    var datePick:UIDatePicker!
    var  data:NSDate!
     init(start:NSDate) {
        startDate = start
        
        super.init(frame:CGRectZero)
        self.addTarget(self, action: sel_getUid("leftBntPress"), forControlEvents: .TouchUpInside)
        self.backgroundColor =  UIColor.blackColor().colorWithAlphaComponent(0.7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showInView(inView:UIView) {
        
        let toolBar = self.creatDateYMDToolBar()
        self.addSubview(toolBar)
        toolBar.snp_makeConstraints { (make) in
            make.bottom.equalTo(-216);
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40);
        }

        datePick = UIDatePicker();
        datePick.backgroundColor = UIColor.whiteColor()
        datePick.datePickerMode = .Date;
        datePick.addTarget(self, action: sel_getUid("dateChange:"), forControlEvents: .ValueChanged)
       self.addSubview(datePick)
       datePick.snp_makeConstraints { (make) in
            make.bottom.equalTo(0);
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(216);
       }
        datePick.date = startDate
        self.data = startDate
        
        inView.addSubview(self)
        self.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
    }
    
    func  creatDateYMDToolBar()->UIView {
        let view = UIView();
        view.backgroundColor = UIColor.systemViewBackgroundColor1()
         let leftBnt = UIButton()
            leftBnt.setTitle("取消", forState: .Normal)
            leftBnt.setTitleColor(UIColor.systemWenZiHeader1(), forState: .Normal)
           leftBnt.addTarget(self, action: sel_getUid("leftBntPress"), forControlEvents: .TouchUpInside)
        
        view.addSubview(leftBnt)
            leftBnt.snp_makeConstraints { (make) in
                make.left.equalTo(kViewStartX)
                make.centerY.equalTo(0)
            }
        
            let rightBnt = UIButton()
            rightBnt.setTitle("确定", forState: .Normal)
            rightBnt.setTitleColor(UIColor.systemWenZiHeader1(), forState: .Normal)
            rightBnt.addTarget(self, action: sel_getUid("rightBntPress"), forControlEvents: .TouchUpInside)
            
            view.addSubview(rightBnt)
            rightBnt.snp_makeConstraints { (make) in
                make.right.equalTo(-kViewStartX)
                make.centerY.equalTo(0)
            }
        
        return view;
        }

    func leftBntPress() {
        self.removeFromSuperview()
    }
    
    func rightBntPress() {
        self.selectDate(self.data)
        self.removeFromSuperview()
    }
    func dateChange(pick:UIDatePicker) {
        self.data = pick.date
    }
    
    
}
