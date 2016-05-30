//
//  YJTableBaseView.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/30.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit

/// tableview的model协议
protocol ModelTableProtocol:YJBaseModelProtocol {
    associatedtype E
    var listData:[E] {get}
    func listData(callback:((httpCode: HttpCodeStatus) -> Void))
    func listDataNext(callback:( (isEnd: Bool,httpCode: HttpCodeStatus) ->Void))
}
extension ModelTableProtocol {
    var listData:[AnyObject!]{
        return []
    }
    func listData(callback:((httpCode: HttpCodeStatus) -> Void)) {
        
    }
    func listDataNext(callback:( (isEnd: Bool,httpCode: HttpCodeStatus) ->Void)) {
        
    }
}
/// tableView 的cell的返回协议
protocol BaseTableProtocol {
    func registerCellClass(tableView:UITableView)
    func registerHeaderFooderClass(tableView:UITableView)
    func reloadTableView()
    
    var style:UITableViewStyle {get}
    var refreshHeader:Bool {get}
    var refreshFooder:Bool {get}
    var refreshNetWork:Bool {get}
    
}

extension BaseTableProtocol where Self:BaseTableView {
    
    func registerCellClass(tableView:UITableView) {
        
    }
    
    func registerHeaderFooderClass(tableView:UITableView) {
        
    }
    
    func reloadTableView() {
        
    }
    
    var style:UITableViewStyle {
        get {
            return .Plain
        }
    }
    var refreshHeader:Bool {
        get {
            return true
        }
    }
    var refreshFooder:Bool {
        get {
            return false
        }
    }
    var refreshNetWork:Bool {
        get {
            return false
       }
    }
}

class BaseTableModel:BaseModel, ModelTableProtocol {
    
    func sendNetworkRequest(callback: ((httpCode: HttpCodeStatus) -> Void)) {
        listData(callback)
    }
}

class BaseTableView: BaseView {
    
    
    var  tableView:UITableView!
    
    var cellDic:[String:UITableViewCell]
    var listData:[AnyObject]!
    override init(frame: CGRect ) {
        
        listData = []
        cellDic = [:]
        super.init(frame: frame)
        tableView = UITableView(frame: frame,style: style)
    }
    
    
    final  var baseTableModel:BaseTableModel! {
        get {
            return viewModel as? BaseTableModel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCustomView() {
         creatTableView()
    }
    
    func refreshTableView(list:[AnyObject]) {
        if NSThread.isMainThread() {
            self.listData = list;
            self.tableView.reloadData()
        }else {
            runInMain() {
                self.listData = list;
                self.tableView.reloadData()
            }
        }
    }
    
    func reloadTableView(){
        self.refreshTableView(self.baseTableModel.listData)
    }
    
    final  func creatTableView() {
        if let _ = tableView.superview {
            return
        }
        self.listData = self.baseTableModel.listData
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.systemViewBackgroundColor()
        self.addSubview(tableView)
        
        tableView.tableFooterView = UIView();
        registerCellClass(tableView)
        registerHeaderFooderClass(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
        setTableDelegate()
        tableView.layoutIfNeeded()
        if refreshHeader {
            tableView.addHeaderWithCallback(){
                [unowned self] in
                self.baseTableModel.listData({ [weak self] (success) -> Void in
                    if let strong = self {
                        strong.tableView.headerEndRefreshing()
                        strong.refreshTableView(strong.baseTableModel.listData)
                    }
                    })
            }
        }
        
        if refreshFooder {
            
            tableView.addFooterWithCallback(){
                [unowned self] in
                self.baseTableModel.listDataNext({ [weak self] (isEnd,httpCode) -> Void in
                    if let strong = self {
                        strong.refreshTableView(strong.baseTableModel.listData)
                        strong.tableView.footerEndRefreshing()
                        strong.tableView.footerHidden = isEnd
                        
                    }
                })
            }
        }
    }
    
}

class BaseTableNoSection: BaseTableView {
    
    final override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    final override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listData.count
        count > 0 ? hiddenEmptyView():showEmptyView()
        return count
    }
    
}

class BaseTableSection: BaseTableView {
    
    
    final  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let count = listData.count
        count > 0 ? hiddenEmptyView():showEmptyView()
        return count
    }
}

extension BaseTableView:UITableViewDataSource,UITableViewDelegate {
    
    func setTableDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
}
extension BaseTableView:BaseTableProtocol {
    
     func refreshView() {
        
        if refreshCount < 1 {
            refreshCount += 1
            return
        }
        if refreshNetWork {
            baseTableModel.listData { [weak self] (success) -> Void in
                
                if success == .success{
                    if let strong = self {
                        strong.hiddenErrorView()
                        strong.refreshTableView(strong.baseTableModel.listData)
                    }
                }
            }
        }else {
            reloadTableView()
        }
        
    }
    
    
}

