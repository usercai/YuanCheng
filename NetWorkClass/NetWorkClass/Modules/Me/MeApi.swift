//
//  MeTool.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Foundation
import Moya

enum MeApi {
    
// MARK: - 获取习题记录
    case QueryExamHistory()
// MARK: - 根据试卷id获取题目 (index-第几题 int，examId-试卷id int)。
    case QueryExamDetial(Int,Int)
// MARK: - 获取作业记录 参数：pageIndex(页码 int)，pageSize（每页条数 int）
    case QueryHomeWork(Int,Int)
// MARK: - 根据id获取作业
    case QueryHomeWorkById(Int)
// MARK: - 获取提问记录
    case QueryAsk(Int,Int)
// MARK: - 根据记录id的内容
    case QueryAskById(Int)
/// MARK: - 获取个人信息
    case QueryUserInfo()
/// MARK: - 获取班级信息
    case QuerySubject()
/// MARK: - 修改头像
    case UpdateStuPicture(String)
// MARK: - 更改未读状态
    case QueryRead(Int,Int)
}

extension MeApi : TargetType{
    var baseURL: URL {
        return URL.init(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .QueryExamHistory():
            
            return "api/User/QueryExamHistory"
        case .QueryExamDetial(_,_):
            return "api/User/QueryExamDetial"
        case .QueryHomeWork(_,_):
            return "api/User/QueryHomeWork"
        case .QueryHomeWorkById(_):
            return "api/User/QueryHomeWorkById"
        case .QueryAsk(_,_):
            return "api/User/QueryAsk"
        case .QueryAskById(_):
            return "api/User/QueryAskById"
        case .QueryUserInfo():
            return "api/User/QueryUserInfo"
        case .QuerySubject():
            return "api/Examin/QuerySubject"
        case .UpdateStuPicture(_):
            return "api/User/UpdateStuPicture"
        case .QueryRead(_, _):
            return "api/User/UpdateIsRead"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        
        return "".data(using: String.Encoding.utf8)!

    }
    
    var task: Task {
        var DataArray:[String:String] = ["Key":KUserInfo.Key]
        switch self {
        case .QueryExamHistory():

            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExamDetial(let index,let examId):
            DataArray["index"] = index.string()
            DataArray["examID"] = examId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryHomeWork(let pageIndex, let pageSize):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryAsk(let pageIndex,let pageSize):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryHomeWorkById(let homeworkId):
            DataArray["homeworkId"] = homeworkId.string()
            
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryAskById(let askId):
            DataArray["askId"] = askId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryUserInfo():
            
            
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QuerySubject():
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .UpdateStuPicture(let picture):
            DataArray["Picture"] = picture
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryRead(let type, let relationid):
            DataArray["type"] = type.string()
            DataArray["relationid"] = relationid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        default:
            
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
    
}

let MeTool = MoyaProvider<MeApi>()

