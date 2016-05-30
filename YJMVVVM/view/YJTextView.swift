//
//  YJTextView.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/19.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit
class YJTextView: UITextView {
    
    var placeholderColor:UIColor
    
    private  var shouldDrawPlaceholder_:Bool
    
   override var text: String! {
        didSet {
            updateShouldDrawPlaceholder_()
        }
    }
    var placeholder:String! {
        
        didSet {
            
            shouldDrawPlaceholder_ = (self.placeholder != nil) && self.text.isEmpty
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        shouldDrawPlaceholder_ = false
        placeholderColor = UIColor.blackColor()
        super.init(coder: aDecoder)
        initialize_()
        
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        shouldDrawPlaceholder_ = false
        placeholderColor = UIColor.blackColor()
        super.init(frame: frame, textContainer: textContainer)
        initialize_()
    }
   
    override func drawRect(rect: CGRect) {
           super.drawRect(rect)
        if  shouldDrawPlaceholder_ {
            placeholderColor.set()
        }
        if self.font != nil {
            let p:NSString = NSString(string: placeholder)
            p.drawWithRect(CGRectMake(8.0, 18.0, self.frame.size.width - 16.0, self.frame.size.height - 16.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : self.font!,NSForegroundColorAttributeName : placeholderColor], context: nil)
        }else {
            let p:NSString = NSString(string: placeholder)
            p.drawWithRect(CGRectMake(8.0, 18.0, self.frame.size.width - 16.0, self.frame.size.height - 16.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSForegroundColorAttributeName : placeholderColor], context: nil)

        }
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension YJTextView {
    
    private func initialize_() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel_getUid("textChanged_:"), name: UITextViewTextDidChangeNotification, object: self)
        shouldDrawPlaceholder_ = false;
    }
    private func updateShouldDrawPlaceholder_() {
        let prev = shouldDrawPlaceholder_
        shouldDrawPlaceholder_ = (placeholder != nil) && self.text.isEmpty
        if prev != shouldDrawPlaceholder_ {
            self.setNeedsDisplay()
        }
        
    }
    private func textChanged(notificaiton:NSNotification) {
        updateShouldDrawPlaceholder_()
    }
}
