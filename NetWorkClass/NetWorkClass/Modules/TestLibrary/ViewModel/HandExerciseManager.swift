//
//  HandExerciseManager.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HandExerciseManager: BaseViewModel {

    let models = Variable<[Model_Subject]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_Subject]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Subject]>) {
            self.models = models
        }
    }
    
    /// 学生提交考试题目（没做的新增，做过的先删除在新增）
    ///
    /// - Parameters:
    ///   - exambodyid: （试卷题目的ID）
    ///   - questionbodyid: （没做的传0，做过的传 questionbodyid 过来,多选逗号拼接）
    ///   - contentaddress: （非选择题图片地址
    ///   - score: (选择题分数，非选择题0，
    ///   - studentid: (考生id))
    /// - Returns:
    func getDataList(exambodyid:Int,questionbodyid:String,contentaddress:String,score:Int,studentid:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_Subject] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            TestLibraryTool.rx.request(TestLibraryApi.SubmitDetailesData(exambodyid, questionbodyid, contentaddress, score, studentid)).asObservable().mapArray(Model_Subject.self).subscribe(onNext: { (models) in
                if models.count == 0 && isReload == false{
                    output.refreshStatus.value = RefreshStatus.noMoreData
                }
                self.models.value = isReload ? models : self.models.value + models
                
            }, onError: { (error) in
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
                
            }, onCompleted: {
                output.refreshStatus.value = isReload ? RefreshStatus.endHeaderRefresh : .endFooterRefresh
                
            }) {
                
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
        return output
    }
    

}
