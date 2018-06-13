//
//  Me_QuesionInfoViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Me_QuesionInfoViewController: BaseViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UITextView!
    var askId = 0
    
    var model:Model_QuestionList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提问"
        self.answer.setC_placeHolerLabel(hc_placeHolerLabel: "暂无评语...")
        // Do any additional setup after loading the view.
    }
    convenience init(askId:Int) {
        self.init()
        self.askId = askId
    }

    override func initData() {
        MeTool.rx.request(MeApi.QueryAskById(self.askId)).asObservable().mapArray(Model_QuestionList.self).subscribe(onNext: { (models) in
            
            if models.count != 0{
                self.model = models.first!
                self.initDataView()
            }
        }, onError: { (error) in
            CProgressHUD.showError(error: "请求失败")
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
    }


    func initDataView() {
        self.question?.text = self.model?.Question.urlDecoded()
        self.answer?.text = self.model?.Answers.urlDecoded()

    }
}
