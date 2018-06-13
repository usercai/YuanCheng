//
//  String+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    func CisEmpty()->Bool{

        return self == "" || self == "null" || self == nil
        
    }
    
    func url() -> URL {
        var url = self
        if self == "" {
            url = "nnnn"
        }
        
        return URL(string: url) ?? URL.init(string: "http://")!
    }
    
    func UrlStr() -> String {
        
        var url = self
        
        if self.characters.count != 0{
            if self.contains("../"){
                url = self.components(separatedBy: "../").last!
            }else if self.contains("/"){
                url.removeFirst()
            }
            url = BaseURL + url
            return url
        }
        return self
    }


    /// 将字符串拆解成Int数组
    ///
    /// - Returns: int数组
    func stringForIntArray() -> [Int] {
        var arr:[Int] = []
        
        if self.contains(",") {
            arr = self.components(separatedBy: ",").map({ (str) -> Int in
                return Int(str) ?? 100
            })
        }else{
            arr.append(Int(self) ?? 100)
        }
        return arr
    }
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    /// JSONString转换为字典
    ///
    /// - Parameter jsonString: <#jsonString description#>
    /// - Returns: <#return value description#>
    func getDictionaryFromJSONString() ->NSDictionary{
        
        let jsonData:Data = self.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
    func timeString() -> String {
        var str = self
        
        //是否包含毫秒
        if self.contains("."){
            str = self.components(separatedBy: ".").first!
        }
        //去掉T
//            if self.contains("T"){
//                str = self.components(separatedBy: "T").first! + self.components(separatedBy: "T").last!
//            }else{
//                return str
//                print("TTTTTTTTTTTTTTTTTTTTTT")
//            }
        
        
        let strtime = str.components(separatedBy: "T").last
        
        if strtime!.contains(":"){
            let arr = strtime?.components(separatedBy: ":")
            
            
            str = str.components(separatedBy: "T").first! + " " + arr![0] + ":" + arr![1]
            
            return str
        }
            
        
        return ""
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    func utf8encodedString() ->String {

        let cs = NSCharacterSet(charactersIn:"!*'();:@&=+$,/?%#[]").inverted
        
        

        let str = self.addingPercentEncoding(withAllowedCharacters: cs)

        return str ?? ""
    }
    
    func typeforTextType() -> TextType {
        switch self {
        case "1":
            return .Danxuan
        case "2":
            return .Duoxuan
        case "3":
            return .Panduan
        case "4":
            return .Tiankong
        case "5":
            return .Jieda
        default:
            return .Other
        }
    }
    
    
    func StringToArray() -> [String] {
        
        
        if AppTool.CisEmpty(str: self) {
            return []
        }
        
        var str = self
        
        if str.hasPrefix("[") { str.removeFirst() }
        if str.hasSuffix("]") { str.removeLast() }
        var dicarr:[String] = []
        if str.contains(","){
            dicarr = str.components(separatedBy: ",")
        }else{
            if str != ""{
                dicarr = [str]
            }else{
                return [self]
            }
        }
        var urlArr:[String] = []
        for dicstr in dicarr {
            let dic = dicstr.getDictionaryFromJSONString()
            var url = "\(dic["contentAddress"])"
            if url.count == 0{
                url = "\(dic["ContentAddress"])"
            }
            
            urlArr.append(dic.allValues.first as! String)
        }
        if urlArr.count == 0 {
            urlArr = [self]
        }
        return urlArr

    }
    
    /// JSONString转换为字典
    ///
    /// - Parameter jsonString:
    /// - Returns:
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
    func timeYearMonthDay() -> String {
        if self.contains("T") {
            return self.components(separatedBy: "T").first!
        }
        return self
    }
    /// 从index到最后一个字段
    ///
    /// - Parameter index: 从那个字段你开始
    /// - Returns: 截取后的字段
    func cGetindexToEnd(index:Int) -> String {
        
        
        let index = self.index(self.startIndex, offsetBy: index)//获取字符d的索引
        
        let result = self.substring(from: index)//从d的索引开始截取后面所有的字符串即defghi
        
        return result
    }
    
    
    //MARK: 将时间显示为（几分钟前，几小时前，几天前）
    func compareCurrentTime() -> String {
        
        var str = self
        
        //是否包含毫秒
        if self.contains("."){
            str = self.components(separatedBy: ".").first!
        }
        //去掉T
        if str.contains("T"){
            str = str.components(separatedBy: "T").first! + " " + str.components(separatedBy: "T").last!
        }else{
            return str
            print("TTTTTTTTTTTTTTTTTTTTTT")
        }
        
        let timeDate = str.timeStringToDate()
        
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        
        var temp:Double = 0
        
        var result:String = ""
        
        if timeInterval/60 < 1 {
            
            result = "刚刚"
            
        }else if (timeInterval/60) < 60{
            
            temp = timeInterval/60
            
            result = "\(Int(temp))分钟前"
            
        }else if timeInterval/60/60 < 24 {
            
            temp = timeInterval/60/60
            
            result = "\(Int(temp))小时前"
            
        }else if timeInterval/(24 * 60 * 60) < 30 {

            temp = timeInterval / (24 * 60 * 60)

            result = "\(Int(temp))天前"
        }else{
            result = self.timeString()
        }
//        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
//
//            temp = timeInterval/(30 * 24 * 60 * 60)
//
//            result = "\(Int(temp))个月前"
//
//        }else{
//
//            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
//
//            result = "\(Int(temp))年前"
//
//        }
        return result
        
    }
    
    //MARK: 时间字符串转date
    func timeStringToDate() ->Date {
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date
            = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    /// 获取http地址文件大小
    func getHttpFileSize(result:@escaping (String)->()) {
        
        DispatchQueue.global().async {
            
            do {
                
                if let url = URL.init(string: self) {
                    
                    let data:NSData = try NSData.init(contentsOf: url)
                    print(CGFloat(data.length) / 1000.0 / 1000.0)
                    result(String.init(format: "%.2fMB", CGFloat(data.length) / 1000.0 / 1000.0))
                    
                } else {
                    
                    print("url错误")
                    result("0.00MB")
                }
                
            } catch {
                
                print("url错误")
                result("0.00MB")
            }
        }
    }
    
    ///label高度自适应
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - labelWidth: 最大宽度
    ///   - attributes: 字体，行距等
    /// - Returns: 高度
    func autoLabelHeight(with labelWidth: CGFloat ,attributes : [NSAttributedStringKey : Any]?=nil ,font:CGFloat) -> CGFloat{
        var size = CGRect()
        let size2 = CGSize(width: labelWidth, height: 0)//设置label的最大宽度
        var att:[NSAttributedStringKey:Any] = [:]
        if attributes == nil {
            att = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)]
        }else{
            att = attributes!
        }
        size = self.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: att , context: nil)
        
        return size.size.height
    }
    
    /// 是否为空
    ///
    /// - Returns:
    func C_isEmpty() -> Bool{

        
        return self == "" || self == "null" || self == "<null>"
    }
}

