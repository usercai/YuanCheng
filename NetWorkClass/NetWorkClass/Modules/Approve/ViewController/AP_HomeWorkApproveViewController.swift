//
//  AP_HomeWorkApproveViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

/// 老师审批作业
class AP_HomeWorkApproveViewController: BaseViewController {


    @IBOutlet weak var homeImg_H: NSLayoutConstraint!
    @IBOutlet weak var homeworkImg: UIImageView!
    @IBOutlet weak var tijiao: UIButton!
    @IBOutlet weak var TiganView: UIView!
    @IBOutlet weak var answertext: UITextView!
    @IBOutlet weak var stuname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tigan: UITextView!
    private var model:Model_HomeWork?
    private var homeworkCollection:CShowCollectionView? = nil
    @IBOutlet weak var HomeWorkTextView_H: NSLayoutConstraint!
    @IBOutlet weak var collectionbackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作业审核"
        // Do any additional setup after loading the view.
    }

    convenience init(model:Model_HomeWork) {
        self.init()
        self.model = model
    }
    
    override func initView() {
        //展示学生作业
        self.tigan.text = self.model?.HomeworkTitle.urlDecoded()
        self.time.text = self.model?.HomeworkDate.timeString()
        self.stuname.text = self.model?.StuName
        self.tigan.isEditable = false
        self.answertext.setC_placeHolerLabel(hc_placeHolerLabel: "请对学生作业进行评价...")
        self.homeworkImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.homeworkImg.addGestureRecognizer(tap)
        
        
        self.homeworkCollection = CShowCollectionView(frame: CGRect.init(x: 0, y: 17, width: SCREEN_WIDTH, height: 60))
        self.collectionbackView.addSubview(self.homeworkCollection!)
        self.homeworkCollection?.collectionView.backgroundColor = BackBlueColor
        self.homeworkCollection?.backgroundColor = BackBlueColor
        guard let files = self.model?.HomeworkFiles else {
            return
        }
        var arr:[String] = []
        
        for model in files {
            arr.append(model.ContentAddress)
        }
        self.homeworkCollection?.setDataSource(images: arr)
        
        self.tijiao.rx.tap.asObservable().subscribe { (event) in
            self.subData()
        }.disposed(by: dis)
        
        self.tijiao.setLayerForNormal(cornerRadius: 5)
        
        ///计算高度
        //题干的高度
        let homeworkText_H = self.tigan.sizeThatFits(CGSize.init(width: SCREEN_WIDTH - 30, height: 300)).height
        self.HomeWorkTextView_H.constant = homeworkText_H
        
        
        if self.model == nil {
            self.homeImg_H.constant = 0
            
        }
        if self.model?.HomeworkImg == "" {
            self.homeImg_H.constant = 0
        }else{
            
            self.homeworkImg.c_setImage(url: self.model!.HomeworkImg)
        }
        
        
    }
    
    @objc func tapClick(){
        
        CImageViewer.shared.showViewer(images: [self.homeworkImg])
    }
    
    func subData()  {

        guard let model = self.model else {
            return
        }

        if self.answertext.text.count == 0 {
            CProgressHUD.showText(text: "写下您的意见吧")
            return
        }
        CProgressHUD.showLoading()
//        isfinish(是否审阅：0未审核 1审核通过 2审核拒绝
        ApproveTool.rx.request(ApproveApi.ReviewHomeworkData(model.HomeworkBodyID, 1, self.answertext.text!)).asObservable().subscribe(onNext: { (res) in
            res.C_mapjson(success: { (dic) in
                PushManager.share.push(type: PushType.Zuoye, PushID: model.HomeworkID, receiveid: model.StudentID)
                CProgressHUD.showText(text: "提交成功")
                self.navigationController?.popViewController(animated: true)
            }, falue: { (code, msg) in

            })
        }, onError: { (error) in
            CProgressHUD.showText(text: "提交失败")

        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }
}
