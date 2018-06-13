//
//  HomePageApi.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/23.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import Moya

enum HomePageApi {
    case QueryInfoList(Int,Int,Int)
// MARK: - 获取通知列表
    case QueryNoticeList(Int,Int)
// MARK: - 获取所有的班级
    case QueryGradeData()
// MARK: - 根据年级ID 获取所有的班级 gradeid(年级的ID)
    case QueryClassData(Int)
// MARK: - 修改学生的班级  classesid（班级的ID
    case UpdateStuGrade(Int)
// MARK: - 根据年月获取本月有作业的 日seldate(日期：年份月份是要查询的，日可以随意,不传默认为当前日期)
    case QueryDayData(String)
// MARK: - 获取作业列表
    case QuerySubjectData(String)
// MARK: - 上传文件(单个文件上传、暂时只能上传jpg，png，bmp格式的图片) 参数：file（base64的图片）,imgName(文件扩展名，不带点)，fileAddress（存储文件地址）
    case Upload(String,String,String)
// MARK: - 提交考试题目
    case SubmitData(Int,Int,String)
// MARK: - 获取资讯内容
    case QueryNotice(Int)
/// MARK: - 推送消息列表 type（登录人0：学生，1：老师）
    case QueryPushMessageList(String,Int,Int)
///学生查看提交过的作业  参数：homeworkid（作业的ID
    case SelectHomeWork(Int)
///返回资讯地址
    case QueryNoticeUrl()
///推送 参数：sendtype（发送人0：学生，1：老师）,type(类型：2-考试，3-提问，4-作业),relationid(对应类型的ExamID,AnswerID,HomeworkID),receiveid(接收人的ID,如果是老师则返回0)。
    case Push(Int,Int,Int,Int)
}

extension HomePageApi:TargetType{
    
    var baseURL: URL {
        
        return URL(fileURLWithPath: BaseURL)
    }
    
    var path: String {
        switch self {
        case .QueryInfoList(_, _, _):
            
            return "api/Notice/QueryInfoList"
        case .QueryNoticeList(_, _):
            return "api/Notice/QueryNoticeList"
        case .QueryClassData(_):
            return "api/Basic/QueryClassData"
        case .QueryGradeData():
            return "api/Basic/QueryGradeData"
        case .UpdateStuGrade(_):
            return "api/Basic/UpdateStuGrade"
        case .QueryDayData(_):
            return "api/HomeWork/QueryDayData"
        case .QuerySubjectData(_):
            return "api/HomeWork/QuerySubjectData"
        case .Upload(_, _, _):
            return "api/FileUpload/Upload"
        case .SubmitData(_, _, _):
            return "api/HomeWork/SubmitData"
        case .QueryNotice(_):
            return "api/Notice/QueryNotice"
        case .QueryPushMessageList(_,_,_):
            return "api/JPushMessage/QueryPushMessageList"
        case .SelectHomeWork(_):
            return "api/HomeWork/SelectHomeWork"
        case .QueryNoticeUrl():
            return "api/Notice/QueryNoticeUrl"
        case .Push(_, _, _, _):
            return "api/JPushMessage/Push"
        default:
            return "api/Notice/QueryInfoList"
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
        var DataArray:[String:Any] = ["Key":KUserInfo.Key]
        switch self {
        case .QueryInfoList(let isCarousel, let pageIndex, let pageSize):
            DataArray["isCarousel"] = isCarousel.string()
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryNoticeList(let pageIndex, let pageSize):
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .UpdateStuGrade(let classesid):
            DataArray["classesid"] = classesid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryClassData(let gradeid):
            DataArray["gradeid"] = gradeid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryGradeData():
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryDayData(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QuerySubjectData(let seldate):
            DataArray["seldate"] = seldate
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .Upload(let file, let imgName, let fileAddress):
            DataArray["file"] = file
            DataArray["name"] = imgName
            DataArray["fileAddress"] = fileAddress
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .SubmitData(let homeworkid, let homeworkbodyid, let jsonHomeworkFiles):
            DataArray["homeworkid"] = homeworkid.string()
            DataArray["homeworkbodyid"] = homeworkbodyid.string()
            DataArray["jsonHomeworkFiles"] = jsonHomeworkFiles
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryNotice(let noticeId):
            DataArray["noticeId"] = noticeId.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryPushMessageList(let type,let pageIndex,let pageSize):
            DataArray["type"] = type
            DataArray["pageIndex"] = pageIndex.string()
            DataArray["pageSize"] = pageSize.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .SelectHomeWork(let homeworkid):
            DataArray["homeworkid"] = homeworkid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .QueryNoticeUrl():
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        case .Push(let sendtype, let type, let relationid, let receiveid):
            DataArray["sendtype"] = sendtype.string()
            DataArray["type"] = type.string()
            DataArray["relationid"] = relationid.string()
            DataArray["receiveid"] = receiveid.string()
            return .requestParameters(parameters: DataArray, encoding: URLEncoding.default)
        default:
            
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}

let homePageTool = MoyaProvider<HomePageApi>()

