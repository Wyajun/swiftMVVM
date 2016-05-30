//
//  Resource.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/25.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
import UIKit
class Resource:NSObject {
    
    
    static func imageName(name:String)->UIImage {
      let  imageName =   name + "@3x.png";
      let image = ResourceManager.sharedInstance.resourceKey(imageName) { (key) -> UIImage? in
           return Resource.imageFormResource(imageName)
        }
        if let resultImage  = image {
            return resultImage
        }
        assert(false,"没有找到你要获取的资源图片\(name)")
        return UIImage()
//        return Resource.imageName("defaultAppImage")false
    }
    
    class func defaultCarImage()->UIImage {
        return Resource.imageName("car_default_pic")
    }
    
     private static func imageFormResource(imageName:String)->UIImage? {
        
        var  imagePath = NSBundle.mainBundle().resourcePath!
             imagePath += "/"
             imagePath += imageName
        
        let imageData = NSData.init(contentsOfFile: imagePath)
        if let data = imageData {
        return UIImage.init(data: data, scale: 3)
        }
        return nil
    }
}

private class ResourceManager {
    let resoureCache:NSCache
    static let sharedInstance: ResourceManager = {
        return ResourceManager()
    }()
    
    init () {
        resoureCache = NSCache.init()
        resoureCache.countLimit = 20;
    }
    func resourceKey(imageName:String,callback:(key:String )->UIImage?) ->UIImage? {
        var image = resoureCache.objectForKey(imageName)
        if let result = image as? UIImage {
            return result
        }
        image = callback(key: imageName);
        if let result = image as? UIImage {
           resoureCache.setObject(result, forKey: imageName)
            return result
        }
        return nil
    }
}