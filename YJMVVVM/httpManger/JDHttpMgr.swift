//
//  JDHttpMgr.swift
//  JiaDao_Seller_Swift
//
//  Created by 王亚军 on 15/12/24.
//  Copyright © 2015年 王亚军. All rights reserved.
//

import Foundation


/// 获取token
func tAuthGetToken(callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("auth/get_token"), parameters: nil, callback1: callback)
}
/// 获取首页滚动图片列表
func tGetIndexSlides(callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("index/get_index_slides"), parameters: nil, callback1: callback)
}
func tUserUpDate(update:[String:String],callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/update"), parameters: update, callback1: callback)
}

func tAuthLogout(callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("auth/logout"), parameters: nil, callback1: callback)
}
/// 获取工作列表
/* ||page| int |false| 页码 ||
||gender| int |false| 性别,0全部,1男,2女 ||
||welfare_id| int |false| 福利, 0全部,1,2,3 ||
||money_start| int |false| 根据薪资排序,1从大到小,0取消此条件 ||
 */
func  tGetWorkList(page:Int,gender:Int,welfare_id:Int,money_start:Int, callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/work_list"), parameters: ["page":String(page),"gender":String(gender),"welfare_id":String(welfare_id),"money_start":String(money_start)], callback1: callback)
}
/// 
func tWorkSearch(keyWord:String,page:Int,callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/search"), parameters: ["page":String(page),"keyword":keyWord], callback1: callback)
}
/// 获取站点
func tGetSites(callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("index/get_sites"), parameters: nil, callback1: callback)
}
/// 选择站点
func tSelectSite(site_id:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("index/select_site"), parameters: ["site_id":site_id], callback1: callback)
}
/// 入职返现
func tWorkRebateList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/rebate_list"), parameters: ["page":page], callback1: callback)
}
/// 免费企业
func tWorkFreeList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/free_list"), parameters: ["page":page], callback1: callback)
}
/// 收费企业
func tWorkChargeList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/charge_list"), parameters: ["page":page], callback1: callback)
}
/// 当天面试
func tWorkInterviewList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/interview_list"), parameters: ["page":page], callback1: callback)
}
/// 工作详情
func tWorkDetail(workId:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/detail"), parameters: ["work_id":workId], callback1: callback)
}
/// 工作申请
func tWorkApply(workId:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/apply"), parameters: ["work_id":workId], callback1: callback)
}
/// 工作收藏
func tWorkFavorite(workID:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/favorite"), parameters: ["work_id":workID], callback1: callback)
}

/// 获取用户信息 user/get_info
func tGetUserInfo(userID:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/get_info"), parameters: ["user_id":userID], callback1: callback)
}
/// 登录 auth/login
func tAuthLogin(username:String,password:String,captcha:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("auth/login"), parameters: ["username":username,"password":password,"captcha":captcha], callback1: callback)
}
/// 注册 auth/register
func tAuthRegister(username:String,nickname:String,password:String,captcha:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("auth/register"), parameters: ["username":username,"nickname":nickname,"password":password,"captcha":captcha], callback1: callback)
}
/*
 || **名称** | **类型** |**必须**| **说明** ||
 || token | string | true | token认证串   ||
 || type | int | true | 类型,0qq,1微信,2新浪微博 ||
 || access_token | string | true | access_token ||
 || openid | string | true | 外部id ||
 */
func tLoginThirdparty(type:Int,access_token:String,openid:String,callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("auth/login_thirdparty"), parameters: ["access_token":access_token,"openid":openid,"type":String(type)], callback1: callback)
}
/// 申请工作列表 user/apply_work_list
func tApplyWorkList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/apply_work_list"), parameters: ["page":page], callback1: callback)
}
/// 收藏工作列表 /user/favorite_work_list
func tFavoriteWorkList(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/favorite_work_list"), parameters: ["page":page], callback1: callback)
}

/// 删除收藏列表 user/del_favorite_work
func tDelFavoriteWork(page:String, callback:HttpResult<AnyObject> ->Void)  {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/del_favorite_work"), parameters: ["page":page], callback1: callback)
}
/// 发布动态 status/update
func tStatusUpdate(content:String ,photo_urls:[String]? ,callback:HttpResult<AnyObject> ->Void) {
    var parame:[String:AnyObject] = [:];
    parame["content"] = content;
    if photo_urls != nil {
        parame["photo_urls"] = photo_urls!
    }
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/update"), parameters: parame, callback1: callback)
}
/// 动态详情 status/detail
func tStatusDetail(status_id:String ,callback:HttpResult<AnyObject> ->Void) {
     HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/detail"), parameters: ["status_id":status_id], callback1: callback)
}
/// 广场动态列表, 后翻页, 即获取比status_id老的动态列表 status/public_timeline
func tPublicTimeline(status_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/public_timeline"), parameters: ["status_id":status_id], callback1: callback)
    
}
/// 广场动态列表, 前翻页, 即获取比status_id新的动态列表 status/public_timeline_new
func tPublicTimelineNew(status_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/public_timeline_new"), parameters: ["status_id":status_id], callback1: callback)
    
}
/// 某人发布的朋友圈列表 status/user_timeline
func tStatusUserTimeline(user_id:String,page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/user_timeline"), parameters: ["user_id":user_id,"page":page], callback1: callback)
    
}
/// 我参与的动态列表 status/relation_timeline
func tStatusRelationTimeline(page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/relation_timeline"), parameters: ["page":page], callback1: callback)
    
}
/// 对动态点赞 status/favorite
func tStatusFavorite(status_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/favorite"), parameters: ["status_id":status_id], callback1: callback)
    
}
///  对动态评论 status/add_comment
func tStatusAddComment(status_id:String,reply_user_id:String?,content:String,callback:HttpResult<AnyObject> ->Void ){
    var dic = ["status_id":status_id,"content":content]
    if reply_user_id != nil {
        dic["reply_user_id"] = reply_user_id!
    }
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/add_comment"), parameters: dic, callback1: callback)
    
}
/// 获取动态评论列表 status/get_comment_list
func tStatusGetCommentList(status_id:String,status_comment_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("status/get_comment_list"), parameters: ["status_id":status_id,"status_comment_id":status_comment_id], callback1: callback)
}
/// 获取活动列表 article/activity_timeline
func tArticleActivityTimeline(page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("article/activity_timeline"), parameters: ["page":page], callback1: callback)
}
// 接口名称: 获取资讯列表 article/news_timeline
func tArticlenewsTimeLineTimeline(page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("article/news_timeline"), parameters: ["page":page], callback1: callback)
}
//* 接口名称: 获取资讯/活动详情
//* 接口地址: /article/detail
func tArticleDetail(article_id:String,callback:HttpResult<AnyObject> ->Void) {
     HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("article/detail"), parameters: ["article_id":article_id], callback1: callback)
}
/// 获取私信会话列表 message/msg_usersessionlist
func tMessageMsgUsersessionList(page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_usersessionlist"), parameters: ["page":page], callback1: callback)
}
/// 删除单条私信 message/msg_del
func tMessageMsgDel(message_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_del"), parameters: ["message_id":message_id], callback1: callback)
}

/// 删除私信用户列表的一个 message/msg_deluser
func tMessageMsgDelUser(with_user_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_deluser"), parameters: ["with_user_id":with_user_id], callback1: callback)
}
/// 获取联系人接口 user/friend_list
func tFriendList(page:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/friend_list"), parameters: ["page":page], callback1: callback)
}
/// 获取图片验证码 index/get_captcha
func tGetCaptcha(callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.token(KJDBASEURLAPPEND("index/get_captcha"), parameters: nil, callback1: callback)
}
/// 上传图片 index/uploadimg

func tUploadimg(datastr:String, callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("index/uploadimg"), parameters: ["datastr":datastr,"type":"jpg"], callback1: callback)
}


/// 获取私信消息记录, 后翻页 message/msg_timeline
func tMessageMsgTimeline(message_id:String,with_user_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_timeline"), parameters: ["message_id":message_id,"to_user_id":with_user_id], callback1: callback)
}
///  获取最新的私信消息, 前翻页 message/msg_timeline_new
func tMessageMsgTimelineNew(message_id:String,with_user_id:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_timeline_new"), parameters: ["message_id":message_id,"to_user_id":with_user_id], callback1: callback)
}
/// 回复/添加私信 message/msg_reply 文本
func tMessagemsgReplyText(to_user_id:String,data:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_reply"), parameters: ["to_user_id":to_user_id,"type":"0","data":data], callback1: callback)
}
/// 回复/添加私信 message/msg_reply 图片
func tMessagemsgReplyImage(to_user_id:String,data:String,callback:HttpResult<AnyObject> ->Void ){
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_reply"), parameters: ["to_user_id":to_user_id,"type":"1","data":data], callback1: callback)
}
///* 接口名称: 把某会话的私信全部置为已读
///* 接口地址: /message/msg_read
func tMessageMsg_read(toUserId:String,callback:HttpResult<AnyObject> ->Void) {
     HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("message/msg_reply"), parameters: ["to_user_id":toUserId], callback1: callback)
}


///* 接口名称: 发送/回复客服
/// * 接口地址: /customer_service/reply

func tCustomerServiceReplyText(data:String,callback:HttpResult<AnyObject> ->Void ){
HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("customer_service/reply"), parameters: ["type":"0","data":data], callback1: callback)
}
/// 回复/添加私信 message/msg_reply 图片
func tCustomerServiceReplyImage(data:String,callback:HttpResult<AnyObject> ->Void ){
   HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("customer_service/reply"), parameters: ["type":"1","data":data], callback1: callback)
}
// * 接口名称: 获取客服对话列表
// * 接口地址: /customer_service/timeline

func tCustomerServiceTimeline(message_id:String,callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("customer_service/timeline"), parameters: ["message_id":message_id], callback1: callback)
}

//  * 接口名称: 重置某对象通知数
//  * 接口地址: /user/reset_notice
func tUserResetNotice(object:String) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/reset_notice"), parameters: ["object":object]) {
        _ in
    }
}


//* 接口名称: 获取用户新通知数
// * 接口地址: /user/get_notice
// * 接口说明: 定时获取, 暂定10分钟一次
func tUserGetNotic(callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/get_notice"), parameters: nil, callback1: callback)
}

// * 接口名称: 获取工作通知列表
// * 接口地址: /work/notice_timeline
func tWorkNoticeTimeLine(work_notice_id:String,callback:HttpResult<AnyObject> ->Void) {
     HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("work/notice_timeline"), parameters: ["work_notice_id":work_notice_id], callback1: callback)
}

// * 接口名称: 获取联系人接口
// * 接口地址: /user/friend_list
func tUserFriendList(page:String,callback:HttpResult<AnyObject> ->Void) {
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/friend_list"), parameters: ["page":page], callback1: callback)
}

//* 接口名称: 获取附近的人列表
// * 接口地址: /user/people_around_list

func tUserPeopleAroundList(page:String,latitude:String,longitude:String,callback:HttpResult<AnyObject> ->Void) {
    
    HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("user/people_around_list"), parameters: ["page":page,"latitude":latitude,"longitude":longitude], callback1: callback)
}


class JDHttpMgr: NSObject {
    static let sharedInstance: JDHttpMgr = {
        return JDHttpMgr()
    }()
    private override init() {
        super.init()
    }
    func tMessageMsgTimeline1(message_id:String,with_user_id:String,callback:CommontHttpCallBack ->Void ) {
        tMessageMsgTimeline(message_id,with_user_id: with_user_id) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                 callback(CommontHttpCallBack(responesd: ["result":data],status: .CommontCallBackSuccess))
            }
                
            
        }
    }
    
    func tMessageMsgTimelineNew1(message_id:String,with_user_id:String,callback:CommontHttpCallBack ->Void ) {
        tMessageMsgTimelineNew(message_id,with_user_id: with_user_id) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                callback(CommontHttpCallBack(responesd:["result":data],status: .CommontCallBackSuccess))
            }
        }
    }
    
    func tMessagemsgReplyText1(to_user_id:String,data:String,callback:CommontHttpCallBack ->Void ) {
        tMessagemsgReplyText(to_user_id,data: data) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                callback(CommontHttpCallBack(responesd: ["result":data],status: .CommontCallBackSuccess))
            }
        }
    }
    func tMessagemsgReplyImage1(to_user_id:String,data:UIImage,callback:CommontHttpCallBack ->Void ) {
        
        let imageData = YJImageMgr.shareImageMgr().upLoaderDataWithImage(data)
        let imageString = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
          tUploadimg(imageString) { [weak self ] result in
            guard let _  = self else {
                return
            }
            switch result {
            case .error(_  ,let  message):
                toastNormalMessage(message)
                 callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                tMessagemsgReplyImage(to_user_id,data: data as! String) {
                    result in
                    switch result {
                    case .error(_   ,let  message):
                        callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
                    case .result(let data) :
                        callback(CommontHttpCallBack(responesd: ["result":data],status: .CommontCallBackSuccess))
                    }
                }

            }
        }

    }
    
    func tMsg_read(toUserId:String) {
        tMessageMsg_read(toUserId) {
            _ in 
        }
    }
    
    func tCustomerMsg_read() {
        tUserResetNotice("customer_service")
    }
    
    func tTongZhiread() {
        tUserResetNotice("work")
    }
    
    func tCustomerServiceReplyText1(data:String,callback:CommontHttpCallBack ->Void ){
        HttpRequestManager.sharedInstance.post(KJDBASEURLAPPEND("customer_service/reply"), parameters: ["type":"0","data":data]) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                callback(CommontHttpCallBack(responesd: ["result":data],status: .CommontCallBackSuccess))
            }
        }
    }
    /// 回复/添加私信 message/msg_reply 图片
    func tCustomerServiceReplyImage1(data:UIImage,callback:CommontHttpCallBack ->Void ){
        let imageData = YJImageMgr.shareImageMgr().upLoaderDataWithImage(data)
        let imageString = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        tUploadimg(imageString) { [weak self ] result in
            guard let _  = self else {
                return
            }
            switch result {
            case .error(_  ,let  message):
                toastNormalMessage(message)
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                tCustomerServiceReplyImage( data as! String) {
                    result in
                    switch result {
                    case .error(_   ,let  message):
                        callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
                    case .result(let data) :
                        callback(CommontHttpCallBack(responesd: ["result":data],status: .CommontCallBackSuccess))
                    }
                }
                
            }
        }

    }
    func tCustomerServiceTimeline1(message_id:String,callback:CommontHttpCallBack ->Void) {
        tCustomerServiceTimeline(message_id) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                callback(CommontHttpCallBack(responesd:["result":data],status: .CommontCallBackSuccess))
            }
        }
    }
    func tWorkNoticeTimeLine1(work_notice_id:String,callback:CommontHttpCallBack ->Void) {
        tWorkNoticeTimeLine(work_notice_id) {
            result in
            switch result {
            case .error(_   ,let  message):
                callback(CommontHttpCallBack(responesd: ["message":message],status: .CommontCallBackError))
            case .result(let data) :
                callback(CommontHttpCallBack(responesd:["result":data],status: .CommontCallBackSuccess))
            }
        }
    }
    
}


