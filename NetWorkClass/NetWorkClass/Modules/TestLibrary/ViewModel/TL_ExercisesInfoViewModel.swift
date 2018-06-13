//
//  TL_ExercisesInfoViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TL_ExercisesInfoViewModel: BaseViewModel {

    let models = Variable<[Model_Danxuan]>([])
    
    
    
    typealias output = OutPut
    
    struct OutPut {
        let models : Driver<[Model_Danxuan]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Danxuan]>) {
            self.models = models
        }
    }
    func getDataList(typeId:Int,pageIndex:Int,pageSize:Int,sId:Int,gId:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_Danxuan] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = OutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            
            TestLibraryTool.rx.request(TestLibraryApi.QuestionList(typeId, pageIndex, pageSize, sId, gId)).asObservable().mapArray(Model_Danxuan.self).subscribe(onNext: { (models) in

                self.models.value = models
                
            }, onError: { (error) in
                
                
            }, onCompleted: {
                
            }) {
                
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
        return output
    }
    
}
