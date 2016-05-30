//
//  CommontCallBack.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/23.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation
enum CommontCallBackStatus:Int {
   case  CommontCallBackNone = 0
   case CommontCallBackWarning = 1
   case CommontCallBackError = 2
   case CommontCallBackSuccess = 3
   case CommontCallBackCancle = 4
}
//enum HttpCodeStatus: Int {
//   case None = -1
//    /// 服务器成功
//   case Success = 0
//    /// 余额不足
//   case YGBZ = 20005
//    /// 更新app
//   case GXAPP = 17
//    /// token错误
//   case TokenCW = 1004
//    /// token 过期
//   case TokenGQ = 1007
//    /// 服务器出错
//   case FWQF = 500
//    /// 没有网络
//   case WWL = -100
//
//}
class CommontHttpCallBack:NSObject {
    var  status:CommontCallBackStatus! // 状态
    var  errorMessage:String!; // code 不等于0 时的信息
    var  result:AnyObject!; // 结果
    init(statue:CommontCallBackStatus,errorMessage:String,result:AnyObject?){
        self.status = statue
        self.errorMessage = errorMessage
        self.result = result
        super.init()
    }
    init(responesd:[String:AnyObject],status:CommontCallBackStatus) {
        
        self.status = status
        self.errorMessage = responesd["message"]?.string
        self.result = responesd["result"]
        super.init()
    }

}