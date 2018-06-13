//
//  TiankongView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class TiankongView: UIView {
    
    var textview : UITextView? = nil
    var image : UIImageView? = nil
    let viewmodel = UpLoadViewModel()
    let handExerciese = HandExerciseManager()
    var model : Model_Danxuan? = nil
    
    var collection : CCollectionView? = nil
    let dis = DisposeBag()
    
    /// 上传之后的图片
    var imageArray:[Model_Path] = []
    
    /// 记录选择的图片
    var imageArr:[Int:[UIImage]] = [:]
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView()  {
        
        self.textview = UITextView(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        self.textview?.isEditable = false
        self.textview?.backgroundColor = UIColor(hex: "#e5f2ff")
        self.textview?.textColor = TextColor
        self.addSubview(self.textview!)
        
        self.image = UIImageView(frame: CGRect.init(x: 20, y: self.textview!.c_maxY(), width: 80, height: 70))
        self.image?.clipsToBounds = true
        self.image?.contentMode = .scaleAspectFill
        self.addSubview(self.image!)
        self.image?.isUserInteractionEnabled = true
        self.image?.setLayerForNormal(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.image?.addGestureRecognizer(tap)
        self.addSubview(self.image!)
        
        self.collection = CCollectionView(frame: CGRect.init(x: 0, y: self.image!.c_maxY(), width: self.frame.width, height: 100))

        self.addSubview(self.collection!)
        
    }
    @objc func tapClick() {
        CImageViewer.shared.showViewer(images: [self.image!])
    }
    
    func setData(model:Model_Danxuan)  {
        //移除
        self.collection?.dataSource.removeAll()
        self.textview?.text = model.Stem.urlDecoded()
        self.model = model
        
        
        if model.StemImg == "" {
            self.image?.c_setHeight(height: 0)
            self.collection?.frame = CGRect.init(x: 0, y: self.textview!.c_maxY(), width: self.frame.width, height: 100)

        }else{
            self.image?.c_setHeight(height: 50)
            self.collection?.frame = CGRect.init(x: 0, y: self.image!.c_maxY(), width: self.frame.width, height: 100)

        }

        self.image?.c_setImage(url: model.StemImg)
        //获取
        self.collection?.setDataSource(images: self.imageArr[model.QuestionID] ?? [])
        self.collection?.isBianhua = false
        if self.imageArr[model.QuestionID]?.count == 0 {
            
//            UIImage.sd_image(with: <#T##Data?#>)
//            self.collection?.setDataSource(images: model.ExamDetails.first?.ContentAddress)
        }
        
    }
    
    func tijiao(){
        if self.model == nil {
            return
        }
        if self.collection?.dataSource.count == 0{
            return
        }
        if self.collection?.isBianhua == false {
            return
        }
        
        imageArr[self.model!.QuestionID] = self.collection?.dataSource
        
        var arr:[String] = []
        
        for image in self.collection!.dataSource {
            
            arr.append(image.base64().utf8encodedString())
        }
        
        let out = self.viewmodel.upLoad(fileArr: arr, name: "jpg", fileAddress: .HomeworkImg)
        out.models.asDriver().drive(onNext: { (models) in
            if models.count == self.collection?.dataSource.count{
                
                self.imageArray = models
                
                self.submitData()
                
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
    func submitData(){
        
        if self.model == nil {
            return
        }
        if self.imageArray.count == 0 {
            return
        }

        let out = self.handExerciese.getDataList(exambodyid: self.model!.ExamBodyID, questionbodyid: "0", contentaddress: self.imageArray.ImageArrtoString(), score: 0, studentid: KUserInfo.student.StudentID)
        out.models.asDriver().drive(onNext: { (models) in
            
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        out.requestCommond.onNext(true)
    }
}
