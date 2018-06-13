//
//  ClassRoomChapterViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ClassRoomChapterViewModel: BaseViewModel {

    
    let models = Variable<[Model_Chapter]>([])
    
    
    
    typealias output = ClassRoomChapterOutput
    
    struct ClassRoomChapterOutput {
        let models : Driver<[Model_Chapter]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Chapter]>) {
            self.models = models
        }
    }
    func getNoticeList(subId:Int) -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_Chapter] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = ClassRoomChapterOutput.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            ClassRoomTool.rx.request(ClassRoomApi.QueryChapter(subId)).asObservable().mapArray(Model_Chapter.self).subscribe(onNext: { (models) in
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
