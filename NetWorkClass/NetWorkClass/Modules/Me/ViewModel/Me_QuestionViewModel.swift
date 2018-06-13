//
//  Me_QuestionViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Me_QuestionViewModel: BaseViewModel {

    let models = Variable<[Model_QuestionList]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_QuestionList]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_QuestionList]>) {
            self.models = models
        }
    }
    func getDataList() -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_QuestionList] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            MeTool.rx.request(MeApi.QueryAsk(self.index, 10)).asObservable().mapArray(Model_QuestionList.self).subscribe(onNext: { (models) in
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