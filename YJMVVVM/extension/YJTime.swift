//
//  YJTime.swift
//  YJMVVVM
//
//  Created by 王亚军 on 16/5/19.
//  Copyright © 2016年 王亚军. All rights reserved.
//

import Foundation
extension String {
    
    func fromatDate()->NSDate {
        let trim = self.trim()
        if trim.isEmpty {
            return NSDate()
        }
       
        let format = FormatMgr.format
        
        if((format.numberFromString(trim)) != nil)
        {
            //为纯数字
            let  sec = Double(trim)
            return NSDate(timeIntervalSince1970:sec!)
        }
        return NSDate()
    }
    
    func trim()->String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func  equalToStringIgnoreCase(aString:String?) ->Bool{
        guard let time  = aString else {
            return false
        }
        return  time.lowercaseString == self.lowercaseString
    }
    
    static func  getDateString(date:NSDate)->String {
        let format = FormatMgr.yymmddformat;
        format.dateFormat = "YYYY-MM-dd"
        return format.stringFromDate(date)
    }
    
    static func isEqualDay(date1:NSDate,date2:NSDate)->Bool {
        let date1str = self.getDateString(date1)
        let date2str = self.getDateString(date2)
        return date1str == date2str
    }
    
}

extension String {
    
    var isToday:Bool {
        get {
            let date = self.fromatDate()
            let todate = self.getToday()
            return String.isEqualDay(date, date2: todate)
        }
    }
    
    var isTomorrow:Bool {
        get {
            let date = self.fromatDate()
            let todate = self.getTomorrow()
            return String.isEqualDay(date, date2: todate)
        }
    }
    
    var isYesterday:Bool {
        get {
            let date = self.fromatDate()
            let todate = self.getYesterday()
            return String.isEqualDay(date, date2: todate)
        }
    }
    
    var isAfterTomorrow:Bool {
        get {
            let date = self.fromatDate()
            let todate = self.getAfterTomorrow()
            return String.isEqualDay(date, date2: todate)
        }
    }
    
    var isWeek:Bool {
        get {
            let timeLong = NSDate().timeIntervalSince1970
            let timeLong1 = self.fromatDate().timeIntervalSince1970
            if timeLong - timeLong1 < 7*86400 {
                return true
            }
            return false
        }
    }
    
    func getToday() -> NSDate {
        return NSDate()
    }
    
    func getTomorrow()->NSDate {
        return NSDate( timeIntervalSinceNow: 86400)
    }
    
    func getYesterday()->NSDate {
        return NSDate( timeIntervalSinceNow: -86400)
    }
    
    func getAfterTomorrow()->NSDate {
        return NSDate( timeIntervalSinceNow: 172800) //后天
    }
}

extension String {
    /**
     *  将当前的时间字符串转换成今天、明天或者后天，其他时间显示月日 最终格式为 今天（周一）
     *
     *  @return
     */
    var timeDescription1:String {
        get {
            let format = FormatMgr.mmddwformat
             format.dateFormat = "(EEEE)"
            let date = self.fromatDate()
            if self.isToday {
                return "今天 " + format.stringFromDate(date)
            }
            if self.isTomorrow {
                return  "明天 " + format.stringFromDate(date)
            }
            if self.isAfterTomorrow {
                return  "后天 " + format.stringFromDate(date)
            }
            format.dateFormat = "MM-dd (EEEE)"
            return format.stringFromDate(date)
        }
    }
    /**
     *  将当前的时间字符串转换成yyyy-mm-dd
     *
     *  @return
     */
    var  timeDescription2:String {
        get {
            return String.getDateString(self.fromatDate())
        }
    }
    /**
     *  将当前的时间字符串转换成qq显示时间
     *
     *  @return
     */
    var  timeDescription3:String {
        get {
            let format = FormatMgr.qqformat
            if self.isToday {
                format.dateFormat = "a hh:mm"
                return format.stringFromDate(self.fromatDate())
            }
            if self.isYesterday {
                return "昨天"
            }
            if self.isWeek {
                format.dateFormat = "EEEE"
                return format.stringFromDate(self.fromatDate())
            }
            format.dateFormat = "MM-dd"
            return format.stringFromDate(self.fromatDate())
           
            
        }
        
    }
    
}

class FormatMgr {
    static let format:NSNumberFormatter = NSNumberFormatter();
    static let yymmddformat:NSDateFormatter = NSDateFormatter()
    static let mmddwformat:NSDateFormatter = NSDateFormatter()
    static let qqformat:NSDateFormatter = NSDateFormatter()
}



