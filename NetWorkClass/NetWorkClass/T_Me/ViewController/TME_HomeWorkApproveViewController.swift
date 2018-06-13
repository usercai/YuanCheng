//
//  AP_HomeWorkApproveViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

/// 老师审批作业
class TME_HomeWorkApproveViewController: BaseViewController {

    @IBOutlet weak var homeworkImgWidth: NSLayoutConstraint!
    @IBOutlet weak var homeworkImg: UIImageView!
    @IBOutlet weak var tijiao: UIButton!
    @IBOutlet weak var TiganView: UIView!
    @IBOutlet weak var answertext: UITextView!
    @IBOutlet weak var stuname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tigan: UITextView!
    private var model:Model_HomeWork?
    private var homeworkCollection:CShowCollectionView? = nil
    
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

        self.stuname.text = self.model?.StuName
        self.tigan.isEditable = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.homeworkImg.addGestureRecognizer(tap)
        
        
        self.homeworkCollection = CShowCollectionView(frame: CGRect.init(x: 0, y: self.tigan.c_maxY(), width: SCREEN_WIDTH, height: 60))
        self.TiganView.addSubview(self.homeworkCollection!)
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
    
        
        if self.model == nil {
            self.homeworkImgWidth.constant = 0

        }
        if self.model?.HomeworkImg == "" {
            self.homeworkImgWidth.constant = 0
        }else{
            
            self.homeworkImg.c_setImage(url: self.model!.HomeworkImg)
        }
        
        self.answertext.text = self.model!.Comment
        self.time.text = self.model?.CreateDataTime.compareCurrentTime()
        self.answertext.isEditable = false
    }
    
    @objc func tapClick(){
        
        CImageViewer.shared.showViewer(images: [self.homeworkImg])
    }
    

}
