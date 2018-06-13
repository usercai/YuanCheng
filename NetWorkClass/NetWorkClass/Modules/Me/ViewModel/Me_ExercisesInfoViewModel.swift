
//
//  Me_ExercisesInfoViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Me_ExercisesInfoViewModel: BaseViewModel {

    let models = Variable<[Model_DanxuanJiLu]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_DanxuanJiLu]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_DanxuanJiLu]>) {
            self.models = models
        }
    }
    func getDataList(index:Int,examId:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_DanxuanJiLu] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in

            MeTool.rx.request(MeApi.QueryExamDetial(index + 1, examId)).asObservable().mapArray(Model_DanxuanJiLu.self).subscribe(onNext: { (models) in
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
