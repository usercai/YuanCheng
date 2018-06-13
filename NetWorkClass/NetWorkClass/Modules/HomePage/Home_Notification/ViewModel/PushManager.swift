//
//  PushManager.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
enum PushType {
    case Kaoshi
    case TiWen
    case Zuoye
}

class PushManager: NSObject {

    static let share = PushManager()
    private let dis = DisposeBag()
    
    override init() {

    }
///参数：sendtype（发送人0：学生，1：老师）,type(类型：2-考试，3-提问，4-作业),relationid(对应类型的ExamID,AnswerID,HomeworkID),receiveid(接收人的ID,如果是老师则返回0)。返回值：msgCode-1发送成功,2参数不足,3发送失败,4sendtype有误,5type有误
    func push(type:PushType,PushID:Int,receiveid:Int) {
        let role = KUserInfo.UserRole == .Student ? 0 : 1
        var pushtype = 0
        switch type {
        case .Kaoshi:
            pushtype = 2
        case .TiWen:
            pushtype = 3
        case .Zuoye:
            pushtype = 4
        default:
            pushtype = 0
        }
        homePageTool.rx.request(HomePageApi.Push( role, pushtype, PushID, receiveid)).asObservable().subscribe(onNext: { (res) in
            res.C_mapjson(success: { (dic) in
                
            }, falue: { (code, msg) in
                
            })
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.dis)
    }
}
