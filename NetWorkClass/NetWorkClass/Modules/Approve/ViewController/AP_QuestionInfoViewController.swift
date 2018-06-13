//
//  AP_QuestionInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
class AP_QuestionInfoViewController: BaseViewController {

    @IBOutlet weak var ScrollContentView: UIView!
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var questiontime: UILabel!
    @IBOutlet weak var questionusername: UILabel!
    @IBOutlet weak var qustiont: UITextView!
    private var collection:CCollectionView? = nil

    private var model = Model_QuestionList(JSON: ["" : ""])
    private var btn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = TINTCOLOR
        btn.setTitleColor(WHITEColor, for: UIControlState.normal)
        btn.setTitle("完成", for: UIControlState.normal)
        btn.titleLabel?.font = CFont_14
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "解答"
        // Do any additional setup after loading the view.
    }

    convenience init(model:Model_QuestionList) {
        self.init()
        self.model = model
    }
    
    override func initView() {
        self.collection = CCollectionView(frame: CGRect.init(x: 0, y: self.answer.c_maxY(), width: SCREEN_WIDTH, height: 70))
        
        self.ScrollContentView.addSubview(self.collection!)
        self.qustiont.text = self.model?.Question.urlDecoded()
        self.qustiont.isEditable = false
        
        self.btn.frame = CGRect.init(x: 20, y: (self.collection?.c_maxY())! + 20, width: SCREEN_WIDTH - 40, height: 35)
        self.ScrollContentView.addSubview(self.btn)
        self.btn.CuttingLayer(cornerRadius: 5, UDLR: .all)
        self.btn.rx.tap.asObservable().subscribe { (event) in
            self.tijiao()
        }.disposed(by: dis)
        self.questiontime.text = self.model?.CreateTime.compareCurrentTime()
        self.questionusername.text = self.model?.StuName
        self.answer.setC_placeHolerLabel(hc_placeHolerLabel: "写下您想说的话")
    }
    

    
    func tijiao() {
        subData()
    }
    
    func subData() {
        
        var imageArr:[Model_Path] = []
        let upload = UpLoadViewModel()
        
        if self.collection?.dataSource.count == 0 {
            CProgressHUD.showText(text: "请选择图片")
            return
        }
        if self.answer.text.CisEmpty()  {
            CProgressHUD.showText(text: "请填写您的意见")
            return
        }
        
        let out = upload.uploadImage(fileArr: self.collection?.dataSource as! [UIImage], name: "jpg", fileAddress: FileAddress.HomeworkImg)
        out.models.asDriver().drive(onNext: { (models) in
            if models.count == self.collection?.dataSource.count{
                imageArr = models
                self.Answer(iamge: imageArr)
            }
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
    }
    
    func Answer(iamge:[Model_Path]) {

        ApproveTool.rx.request(ApproveApi.ReviewAnswerData(self.model?.AnswerID ?? 0,self.answer.text ?? "",iamge.ImageArrtoString())).asObservable().subscribe(onNext: { (res) in
            
            res.C_mapjson(success: { (dic) in
                PushManager.share.push(type: PushType.TiWen, PushID: self.model?.AnswerID ?? 0, receiveid: self.model?.StudentID ?? 0)
                self.navigationController?.popViewController(animated: true)
            }, falue: { (code, msg) in
                
            })
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
    
}
