//
//  JDTableHeaderView.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 16/1/12.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import UIKit

class JDTableHeaderView: UITableViewHeaderFooterView {
   private var title:String!
   private let titleLab:UILabel
    override init(reuseIdentifier: String?) {
        titleLab = creatLab("", font: UIFont.systemFontOfSize(12), titleColor: UIColor.systemWenZiHeader2())
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLab)
        titleLab.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(kViewStartX)
            make.centerY.equalTo(0)
        }
        self.contentView.backgroundColor = UIColor.systemViewBackgroundColor()
        KBottomFGX(self.contentView)
    }

    var headTitle:String {
        get {
            return title
        }
        set {
            title = newValue
            titleLab.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
