//
//  Response+ObjectMapper.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper


// MARK: - Json -> Model
extension Response {
    // 将Json解析为单个Model
    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        
        guard let json = try mapJSON() as? [String : Any] else {
            
            
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonArr = (json["data"] as? [Any]) else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let object = Mapper<T>().map(JSONObject: jsonArr) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:BaseMappable>(_ type: T.Type) throws -> [T] {
        
        guard var json = try mapJSON() as? [String : Any] else {
            
            
            throw MoyaError.requestMapping("11111")
        }
        
        print(self.request?.url)
        print(json)

        if let json = try mapJSON() as? [String:Any]{
            
            let msgStr = json["msg"] as? String
            if let code = json["msgCode"] as? Int {
                
                if code == 1{

                }else if code == 2{
                    if msgStr != "数据为空"{
                        CProgressHUD.showError(error: msgStr ?? "参数缺失")
                        
                    }

                }else if code == 3{
                    if msgStr != "数据为空"{
                        CProgressHUD.showError(error: msgStr ?? "msgCode=3")
                        
                    }
                }
                
            }
        }
        
        if let jsonArr = json["data"] as? [String:Any] {
            json = ["data":[jsonArr]]
        }
        guard let jsonArr = (json["data"] as? [[String : Any]]) else {
//            CProgressHUD.showError(error: json["msg"] as! String)
            throw MoyaError.requestMapping("错误")
        }
        
        return Mapper<T>().mapArray(JSONArray: jsonArr)
    }
    
    public func mapcorrectJson() throws -> Any{
        
        guard let json = try mapString() as? String else{

            throw ResponseCode.JsonError
        }
        guard let dict = json.getDictionaryFromJSONString() as? [String:Any] else {
            throw ResponseCode.JsonError
        }
        guard let code = dict["msgCode"] else {
            throw ResponseCode.JsonError
        }
        guard let codestr = code as? Int else{
            throw ResponseCode.JsonError
        }
        if codestr == 1{
            return dict["data"]
        }else if codestr == 2{
            throw ResponseCode.ParameterError
        }else{
            throw ResponseCode.otherError
        }
        
    }
    
    typealias success = (Dictionary<String, Any>)->()
    typealias error = (ResponseCode,String)->()
    func C_mapjson(success:success,falue:error){
        
        do {
            if let json = try mapJSON() as? [String:Any]{
                
                let msgStr = json["msg"] as? String
//                print(json)
//                print(response?.url)
                if let code = json["msgCode"] as? Int {
                    
                    if code == 1{
                        if let data = json["data"] as? [String:Any]{
                            success(data)
                        }else if let data = json["data"] as? [Any]{
                            success(["data":data])
                        }else{
                            success(["data":"null"])
                        }
                    }else if code == 2{
                        if msgStr != "数据为空"{
                            CProgressHUD.showError(error: msgStr ?? "参数缺失")
                        }
                        falue(.ParameterError, "参数缺失")
                    }else if code == 3{
                        if msgStr != "数据为空"{
                            CProgressHUD.showError(error: msgStr ?? "msgCode=3")

                        }

                        falue(.otherError, json["msg"] as! String)
                    }
                    
                }else{
                    CProgressHUD.showError(error: msgStr ?? "msgCode=3")

                    falue(.JsonError, "数据格式错误,msgCode")
                }
                
            }else{
                CProgressHUD.showError(error: "数据格式错误")

                falue(.JsonError, "数据格式错误")
            }
            
        } catch  {
            CProgressHUD.showError(error: "数据格式错误")

            falue(.JsonError, "数据格式错误")
        }
    }
    
    


    
}

// MARK: - Json -> Observable<Model>
extension ObservableType where E == Response {
    // 将Json解析为Observable<Model>
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            
            
            return Observable.just(try response.mapObject(T.self))
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {

        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
    public func C_mapJson() -> Observable<Any> {
        
        return flatMap({ (response) -> Observable<Any> in
            return Observable.just(try response.mapcorrectJson())
        })
    }

    
}


enum ResponseCode: String {
    
// MARK: - 成功
    case Success
    
// MARK: - 参数错误
    case ParameterError

// MARK: - Joson格式错误
    case JsonError
    
// MARK: - 其他错误
    case otherError
}

extension ResponseCode: Swift.Error {
    
    
    
    
}





