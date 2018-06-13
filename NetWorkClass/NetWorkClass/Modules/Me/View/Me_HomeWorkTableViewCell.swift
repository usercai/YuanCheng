//
//  Me_HomeWorkTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Me_HomeWorkTableViewCell: UITableViewCell {

    @IBOutlet weak var read: UIView!
    @IBOutlet weak var hometime: UILabel!
    @IBOutlet weak var homeInfo: UILabel!
    @IBOutlet weak var hometitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    ///我的作业记录
    func cellforModel(model:Model_HomeWork){
        self.read.isHidden = (model.IsRead == 1)
        self.hometime.text = model.HomeworkDate.timeString()
        self.homeInfo.text = model.HomeworkTitle.urlDecoded()
        self.hometitle.text = model.SubjectName
    }
    ///我的习题记录
    func cellforModel(model:Model_Exam){
        self.read.isHidden = (model.IsRead == 1)
        self.hometime.text = model.CreateTime.timeString()
        self.homeInfo.text = "共有" + model.Count.string() + "道题"
        self.hometitle.text = model.ExamName
    }
    ///我的提问记录
    func cellforModel(model:Model_QuestionList) {
        self.read.isHidden = (model.IsRead == 1)
        self.hometime.text = model.CreateTime.timeString()
        self.homeInfo.text = "解答 : " + (model.Answers.C_isEmpty() ? "没有解答" : model.Answers)
        self.hometitle.text = model.Question.urlDecoded()
        
    }
    
}
