//
//  TME_API.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum TME_API {
/// 获取习题记录（老师）pageIndex(页码 int)，pageSize（每页条数 int）gradeid（年级ID）subjectid（科目ID）
    case QueryTeaExamHistory(Int,Int,Int,Int)
/// 获取老师以批改试卷的年级和学科
    case QueryExaminSubject()
/// 获取提问记录
    case QueryTeaAsk(Int,Int)
/// 根据年月获取本月已批改作业的日
    case QueryDayData(String)
/// 根据年月日 获取老师已批改的年级和学科
    case QuerySubject(String)
/// 根据登陆老师获取作业列表
    case QueryExaminHomeworkList(Int,Int,Int,Int,String)
    
}

extension TME_API:TargetType{
    var baseURL: URL {
        return URL.init(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .QueryTeaExamHistory(_, _, _, _):
            return "api/User/QueryTeaExamHistory"
        case .QueryExaminSubject():
            return "api/User/QueryExaminSubject"
        case .QueryTeaAsk(_, _):
            return "api/User/QueryTeaAsk"
        case .QueryDayData(_):
            return "api/User/QueryDayData"
        case .QueryExaminHomeworkList(_, _, _, _, _):
            return "api/User/QueryExaminHomeworkList"
        case .QuerySubject(_):
            return "api/User/QuerySubject"
        default:
            return "api/User/QueryTeaExamHistory"
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
        case .QueryTeaExamHistory(let pageIndex, let pageSize, let gradeid, let subjectid):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            DataArray["gradeid"] = gradeid.string()
            DataArray["subjectid"] = subjectid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminSubject():
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryTeaAsk(let pageIndex, let pageSize):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryDayData(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryExaminHomeworkList(let pageIndex, let pageSize, let gradeid, let subjectid, let datetime):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            DataArray["gradeid"] = gradeid.string()
            DataArray["subjectid"] = subjectid.string()
            DataArray["datetime"] = datetime
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QuerySubject(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)

        default:
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

let TME_Tool = MoyaProvider<TME_API>()
