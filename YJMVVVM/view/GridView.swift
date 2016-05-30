//
//  GridView.swift
//  tiefanwan
//
//  Created by 王亚军 on 16/4/29.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class GridView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    typealias gridSelectIndexPath = (indexPath: NSIndexPath)->Void
    private let collectView: UICollectionView!
    private let layout:UICollectionViewFlowLayout
    private let reuseIdentifier = "ReuseIdentifier"
    var cellCallback:gridSelectIndexPath!
    
    var list:[NSObject]!
    private override init(frame: CGRect) {
        layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        list = []
        collectView = UICollectionView(frame: CGRectZero,collectionViewLayout: layout)
        super.init(frame: frame)
        collectView.delegate = self;
        collectView.dataSource = self;
        collectView.scrollEnabled = false
        self.addSubview(collectView)
        self.backgroundColor = UIColor.whiteColor()
        collectView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
    }
    convenience init(cellClass:AnyClass?) {
        self.init(frame: CGRectZero)
        collectView.registerClass(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadData()  {
        collectView.reloadData()
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.setCellData(list[indexPath.row])
        return cell;
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let select = cellCallback else {
            return
        }
        select(indexPath: indexPath);
    }
    
    var itemSize:CGSize {
        get {
            return layout.itemSize
        }
        set {
        layout.itemSize = newValue;
        }
    }
    var lineSpace:CGFloat {
        get {
            return layout.minimumLineSpacing
        }
        set {
            layout.minimumLineSpacing = newValue;
        }
    }
    var rowSpace:CGFloat {
        get {
            return layout.minimumInteritemSpacing
        }
        set {
            layout.minimumInteritemSpacing = newValue;
        }
    }
    override var backgroundColor: UIColor? {
        willSet(newValue) {
            collectView.backgroundColor = newValue
        }
    }
    func cellWithIndexPath(indepath:NSIndexPath)->UICollectionViewCell? {
        return collectView.cellForItemAtIndexPath(indepath)
    }
}

extension UICollectionViewCell:gridViewCellProtocol {
    func setCellData(obj: AnyObject) {
        
    }
}

protocol gridViewCellProtocol {
    func setCellData(obj:AnyObject)
}

