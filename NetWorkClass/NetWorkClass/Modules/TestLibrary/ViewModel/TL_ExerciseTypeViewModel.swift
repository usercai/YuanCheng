//
//  TL_ExerciseTypeViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TL_ExerciseTypeViewModel: BaseViewModel {

    let models = Variable<[Model_ExercisesType]>([])
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_ExercisesType]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_ExercisesType]>) {
            self.models = models
        }
    }
    func getDataList(sId:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_ExercisesType] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            TestLibraryTool.rx.request(TestLibraryApi.QuestionTypeList(sId,KUserInfo.user.GradeID)).asObservable().mapArray(Model_ExercisesType.self).subscribe(onNext: { (models) in
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
