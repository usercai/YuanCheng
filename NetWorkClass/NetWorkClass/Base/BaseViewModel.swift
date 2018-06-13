//
//  BaseViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import Moya

enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class BaseViewModel: NSObject {

    // 存放着解析完成的模型数组
//    let models = Variable<[BaseMappable]>([])
    // 记录当前的索引值
    var index: Int = 1
    
    
    
    
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<BaseNetWorkTool>()
    
    typealias Input = BaseViewModelInput
//    typealias Output = BaseViewModelOutput
    
    struct BaseViewModelInput {
        var Api : TargetType
        let ModelType:Mappable.Type
        
        
        init<T:Mappable>(Api:TargetType , ModelType:T.Type) {
            self.Api = Api
            self.ModelType = ModelType
        }
        
    }
    
//    struct BaseViewModelOutput {
//        // tableView的sections数据
//        let sections: Driver<[BaseSection]>
//        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
//        let requestCommond = PublishSubject<Bool>()
//        // 告诉外界的tableView当前的刷新状态
//        let refreshStatus = Variable<RefreshStatus>(.none)
//
//        init(sections: Driver<[BaseSection]>) {
//            self.sections = sections
//        }
//    }
//
    func registerCell(tableView:UITableView)  {
        

    }
    
//    func transform(input: BaseViewModel.BaseViewModelInput) -> BaseViewModel.BaseViewModelOutput {
//        let sections = models.asObservable().map { (models) -> [BaseSection] in
//            // 当models的值被改变时会调用
//            return [BaseSection(items: models)]
//            }.asDriver(onErrorJustReturn: [])
//
//        let output = BaseViewModelOutput(sections: sections)
//
//        output.requestCommond.subscribe(onNext: {[unowned self] isReloadData in
//            self.index = isReloadData ? 1 : self.index+1
//
////            self.provider.rx.request(BaseNetWorkTool.data(Api: "", DataSource: ["" : ""])).subscribe(onSuccess: { (data) in
////
////            }, onError: { (error) in
////
////            }).disposed(by: self.disposeBag)
////
//            let parameter = Parameter(Api: "", DataSource: ["" : ""])
//
//
//            self.provider.rx.request(input.Api.data(Api: parameter)).asObservable().mapArray(testmodel.self).subscribe({ [weak self] (event) in
//                switch event {
//                case let .next(modelArr):
//                    self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
//                case let .error(error): break
//
//                case .completed:
//                    output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
//                }
//            }).addDisposableTo(self.disposeBag)
//        }).disposed(by: self.disposeBag)
//
//        return output
//    }
}

