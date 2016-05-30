//
//  YJImageMgr.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/18.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
import UIKit

/*
 * 修正图片显示方向不正确问题 主要拍照
 */

func fixOrientation(image:UIImage)->UIImage {
    // No-op if the orientation is already correct
    if (image.imageOrientation == .Up) {
      return image
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    var  transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
    case .Down,.DownMirrored:
        transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI));
        break;
        
    case .Left,.LeftMirrored:
        transform = CGAffineTransformTranslate(transform, image.size.width, 0);
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2));
        break;
        
    case .Right,.RightMirrored:
        transform = CGAffineTransformTranslate(transform, 0, image.size.height);
        transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2));
        break;
    case .Up,.UpMirrored:
        break;
    }
    
    switch (image.imageOrientation) {
    case .UpMirrored,.DownMirrored:
        transform = CGAffineTransformTranslate(transform, image.size.width, 0);
        transform = CGAffineTransformScale(transform, -1, 1);
        break;
        
    case .LeftMirrored,.RightMirrored:
        transform = CGAffineTransformTranslate(transform, image.size.height, 0);
        transform = CGAffineTransformScale(transform, -1, 1);
        break;
    case .Up,.Down,.Left,.Right:
        break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue
    
    let  ctx = CGBitmapContextCreate(nil, CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage),
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             bitmapInfo);
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
    case .Left,.LeftMirrored,.Right,.RightMirrored:
        CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
        break;
        
    default:
        CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
        break;
    }
    
    // And now we just create a new UIImage from the drawing context
    let  cgimg = CGBitmapContextCreateImage(ctx);
    let img = UIImage(CGImage: cgimg!)
    return img;

}
/*
 * max : 单位 M
 */
func fixImage(image:UIImage,maxSize:CGFloat)->NSData {
    var  i:CGFloat = 0.5
    var  imageData:NSData
    repeat {
        imageData = UIImageJPEGRepresentation(image, i)!;
        i -= 0.1;
    } while ((imageData.length > Int( maxSize * 1024 * 1024)) && (i >= 0.1));
    
    return imageData;
}
/**
 *  压缩上传图片
 *
 *  @param upImage 要压缩的图片
 *
 *  @return 压缩后的图片数据
 */

func upLoaderDataWithImage(image:UIImage) -> NSData {
    return upLoaderDataWithImage(image, maxCCSize: CGSizeMake(kScreenWidth, kScreenHeight), maxNRsize: 0.3)
}


/**
 *  压缩具体的图片
 *
 *  @param upImage 需要压缩的图片
 *  @param ccSize  图片最大尺寸
 *  @param crSize  图片最大内容 单位M
 *
 *  @return 压缩后的图片数据
 */
func upLoaderDataWithImage(upImage:UIImage,maxCCSize:CGSize,maxNRsize:CGFloat)->NSData {
     var  image = fixOrientation(upImage)
     let imageScaleSize = CGSizeMake(upImage.size.width * upImage.scale, upImage.size.height * upImage.scale)
    if (imageScaleSize.height > maxCCSize.height || imageScaleSize.width > maxCCSize.width) {
        let  cutSize =  cutImageSize(imageScaleSize ,ccSize:maxCCSize)
        image = imageCutImage(upImage ,size:cutSize)
    }
    return fixImage(image, maxSize: maxNRsize)
}

/**
 *  图片尺寸裁剪算法 会保证最小压缩的边，不会小于要求裁剪边的一半
 *  如果图片自身的一条边比对应要求的边的一半还小，则直接返回
 *  @param imageSize 图片的尺寸
 *  @param ccSize    限制的尺寸
 *
 *  @return 计算后图片压缩的尺寸
 */
func cutImageSize(imageSize:CGSize,ccSize:CGSize)->CGSize {
    // 1 图片一条边小于对应边的一半，则直接返回
    if(imageSize.width <= ccSize.width/2 || imageSize.height <= ccSize.height/2) {
        return imageSize;
    }
    // 2 计算图片的放缩比
    let  scaleH:CGFloat = ccSize.height/imageSize.height;
    let  scaleW:CGFloat = ccSize.width/imageSize.width;
    // 3 如果图片的高放缩比小于宽的放缩比
    if (scaleH < scaleW) {
        let  width = ccSize.width/2;
        if (scaleH * imageSize.width < width) {
            return CGSizeMake(width, width/imageSize.width * imageSize.height);
        }
        return CGSizeMake(imageSize.width * scaleH, ccSize.height);
    }else {
        let  height:CGFloat = ccSize.height/2;
        if (scaleW * imageSize.height < height) {
            return CGSizeMake(height/imageSize.height * imageSize.width, height);
        }
        return CGSizeMake(ccSize.width, imageSize.height*scaleW);
    }
}

/**
 *  缩放图片
 *
 *  @param image 原图
 *  @param size  缩放size
 *
 *  @return 依据size缩放后的图片
 */
func imageCutImage(image:UIImage,size:CGSize)->UIImage {
    UIGraphicsBeginImageContext(size);
    image.drawInRect(CGRectMake(0, 0, size.width, size.height))
    let scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    if(scaleImage == nil) {
        return image;
    }
    UIGraphicsEndImageContext();
    return scaleImage;
}



