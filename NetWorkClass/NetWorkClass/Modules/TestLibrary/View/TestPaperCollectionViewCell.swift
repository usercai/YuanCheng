//
//  TestPaperCollectionViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestPaperCollectionViewCell: UICollectionViewCell {

    
    let dis = DisposeBag()
    
    /// 模拟题试题
    let viewmodel = TL_TestPaperInfoViewModel()
    var examID = 0
    var Danxuan:DanxuanView?
    var tinakong:TiankongView?


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func initView(){
        self.Danxuan = Bundle.main.loadNibNamed("DanxuanView", owner: nil, options: nil)?.first as? DanxuanView
        Danxuan?.frame = self.frame
        Danxuan?.isHidden = true
        self.addSubview(Danxuan!)
        
        self.tinakong = TiankongView(frame: self.frame)
        self.tinakong?.isHidden = true
        self.addSubview(self.tinakong!)
    }
    
    func cellForModel(model:Model_Danxuan){
        
        if model.TypeName == "单选" || model.TypeName == "多选"{
            
            self.Danxuan?.isHidden = false
            self.tinakong?.isHidden = true
            self.Danxuan?.getData(model: model)
        }
        
        if model.TypeName == "填空"{
            self.tinakong?.isHidden = false
            self.Danxuan?.isHidden = true
            self.tinakong?.setData(model: model)
        }
        
    }


//    func hidenView() {
//        self.Danxuan?.isHidden = true
//        self.tinakong?.isHidden = true
//    }
//    
    
}
