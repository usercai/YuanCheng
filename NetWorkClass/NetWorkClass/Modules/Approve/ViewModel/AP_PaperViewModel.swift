//
//  AP_PaperViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AP_PaperViewModel: BaseViewModel {

    let models = Variable<[Model_TestPaper]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_TestPaper]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_TestPaper]>) {
            self.models = models
        }
    }
    
    func getDataList(gradeId:Int,subjectid:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_TestPaper] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            ApproveTool.rx.request(ApproveApi.QueryExaminList(self.index, 10, gradeId, subjectid)).asObservable().mapArray(Model_TestPaper.self).subscribe(onNext: { (models) in
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
