//
//  AP_QuestionInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ObjectMapper
class TME_QuestionInfoViewController: BaseViewController {

    @IBOutlet weak var ScrollContentView: UIView!
    @IBOutlet weak var answer: UITextView!
    @IBOutlet weak var questiontime: UILabel!
    @IBOutlet weak var questionusername: UILabel!
    @IBOutlet weak var qustiont: UITextView!
    private var collection:CShowCollectionView? = nil

    private var model = Model_QuestionList(JSON: ["" : ""])

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
        self.collection = CShowCollectionView(frame: CGRect.init(x: 0, y: self.answer.c_maxY(), width: SCREEN_WIDTH, height: 70))
        
        self.ScrollContentView.addSubview(self.collection!)
        self.qustiont.text = self.model?.Question.urlDecoded()
        self.questiontime.text = self.model?.CreateTime.compareCurrentTime()
        self.questionusername.text = self.model?.StuName
        self.qustiont.isEditable = false
        self.answer.text = self.model?.Answers
        self.collection?.setDataSource(images: self.model!.AnswersImg.StringToArray())
        self.answer.isEditable = false
    }
    
}
