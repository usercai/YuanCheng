//
//  Model_PushModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
/**
 {
 "PushMessageID": 3,
 "SendType": 1,
 "SendID": 15,
 "ReceiveID": 10,
 "Type": 3,
 "RelationID": 1,
 "SendContent": "试卷已审批",
 "CreateDateTime": "2017-12-11T10:03:21"
 },
 */
struct Model_PushList: Mappable{
    mutating func mapping(map: Map) {
        PushMessageID <- map["PushMessageID"]
        SendType <- map["SendType"]
        SendID <- map["SendID"]
        ReceiveID <- map["ReceiveID"]
        Type <- map["Type"]
        SendContent <- map["SendContent"]
        RelationID <- map["RelationID"]
        CreateDateTime <- map["CreateDateTime"]
    }
    init?(map: Map) {
        
    }
    var PushMessageID = 0
    var SendType = 0
    var SendID = 0
    var ReceiveID = 0
    var `Type` = 0
    var RelationID = 0
    var SendContent = ""
    var CreateDateTime = ""
    
}
