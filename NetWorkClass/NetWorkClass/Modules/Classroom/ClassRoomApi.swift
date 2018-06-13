//
//  ClassRoomApi.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum ClassRoomApi {
    
// MARK: - 根据年级获取学科列表
    case QuerySubjectList(Int)
    
// MARK: - 获取章节
    case QueryChapter(Int)
// MARK: - 根据章节获取资料
    case QueryFile(Int)
// MARK: - 根据章节获取视频
    case QueryVideo(Int)
// MARK: - 提交提问 参数：content（提问内容），videoId(视频Id int),chapterId(章节id int),subjectId(科目id int),askType(1-视频，5-章节 int)
    case SubmitAsk(String,Int,Int,Int,Int)
// MARK: - 根据地址获取资料
    case QueryFileByPath(String)
    
}

extension ClassRoomApi:TargetType{
    
    var baseURL: URL {
        
        return URL(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .QuerySubjectList(_):
            
            return "api/Subject/QuerySubjectList"
        case .QueryChapter(_):
            return "api/Subject/QueryChapter"
        case .QueryFile(_):
            return "api/Subject/QueryFile"
        case .QueryVideo(_):
            return "api/Subject/QueryVideo"
        case .SubmitAsk(_, _, _,_,_):
            return "api/Subject/SubmitAsk"
        case .QueryFileByPath(let fileContent):
            return fileContent
        default:
            return "api/Subject/QuerySubjectList"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
        
    }
    
    var task: Task {
        var DataArray:[String:String] = ["Key":KUserInfo.Key]
        switch self {
        case .QuerySubjectList(let gId):
            DataArray["gId"] = gId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryChapter(let subId):
            DataArray["subId"] = subId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryFile(let cId):
            DataArray["cId"] = cId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryVideo(let cId):
            DataArray["cId"] = cId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .SubmitAsk(let content, let videoId, let chapterId,let subjectId,let askType):
            DataArray["content"] = content
            DataArray["videoId"] = videoId.string()
            DataArray["subjectId"] = subjectId.string()
            DataArray["askType"] = askType.string()
            DataArray["chapterId"] = chapterId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryFileByPath(let fileContent):
            
            let des:DownloadDestination = { temporaryURL, response in
                
                print("---------------")
                print(DefaultDownloadDir.appendingPathComponent(fileContent.components(separatedBy: "/").last ?? fileContent))
                print("---------------")
                return (DefaultDownloadDir.appendingPathComponent(fileContent.components(separatedBy: "/").last ?? fileContent), [])
                //.removePreviousFile //覆盖
            }
            
            
            return .downloadDestination(des)
        default:
            
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
    //.removePreviousFile //覆盖
}

//默认下载保存地址（用户文档目录）
var DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()


let ClassRoomTool = MoyaProvider<ClassRoomApi>()
