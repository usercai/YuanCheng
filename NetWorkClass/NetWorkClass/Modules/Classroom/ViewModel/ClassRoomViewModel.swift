//
//  ClassRoomViewModel.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import Moya

class ClassRoomViewModel: BaseViewModel {

    
    let title = ["语文","数学","英语","化学","物理"]
    
    override init() {
        super.init()
        
    }

    
    
    let models = Variable<[Model_Subject]>([])
    
    typealias output = ClassRoomSujectOutPut
    
    struct ClassRoomSujectOutPut {
        let models : Driver<[Model_Subject]>
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = Variable<RefreshStatus>(.none)
        
        init(models:Driver<[Model_Subject]>) {
            self.models = models
        }
    }
    func getSubjectList() -> output{
        
        let models = self.models.asObservable().map { (models) -> [Model_Subject] in
            return models
            }.asDriver(onErrorJustReturn: [])
        
        let output = ClassRoomSujectOutPut.init(models: models)
        output.requestCommond.subscribe(onNext: { (isReload) in
            self.index = isReload ? 1 : self.index + 1
            ClassRoomTool.rx.request(ClassRoomApi.QuerySubjectList(KUserInfo.user.GradeID)).asObservable().mapArray(Model_Subject.self).subscribe(onNext: { (modelArr) in
                if modelArr.count == 0 && isReload == false{
                    output.refreshStatus.value = RefreshStatus.noMoreData
                }
                self.models.value = isReload ? modelArr : self.models.value + modelArr
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





