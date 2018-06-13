//
//  AP_HomeWorkInfoViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class TME_HomeWorkInfoViewModel: BaseViewModel {

    let models = Variable<[Model_HomeWork]>([])
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_HomeWork]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_HomeWork]>) {
            self.models = models
        }
    }
    func getDataList(gradeid:Int,subjectid:Int,datetime:String) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_HomeWork] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            print(self.index)
            TME_Tool.rx.request(TME_API.QueryExaminHomeworkList(self.index, 15, gradeid, subjectid, datetime)).asObservable().mapArray(Model_HomeWork.self).subscribe(onNext: { (models) in
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
