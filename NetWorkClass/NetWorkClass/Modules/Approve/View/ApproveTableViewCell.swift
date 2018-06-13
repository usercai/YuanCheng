//
//  ApproveTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ApproveTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var aptitle: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.name.setLayerForNormal(cornerRadius: self.name.c_w/2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 审批问题列表
    ///
    /// - Parameter model: question
    func cellformodel(model:Model_QuestionList)  {
        
        self.time?.text = model.CreateTime.compareCurrentTime()
        if model.StuName.count <= 2 {
            self.name?.text = model.StuName
        }else{
            self.name?.text = model.StuName.cGetindexToEnd(index: model.StuName.count - 2)
        }
        self.name?.backgroundColor = randomColor
        self.info?.text = model.Question.urlDecoded()
        self.aptitle?.text = model.StuName + "的问题"
    }
    
    /// 审批作业列表
    ///
    /// - Parameter model: 作业model
    func cellformodel(model:Model_HomeWork) {
        self.time?.text = model.HomeworkDate.compareCurrentTime()
        if model.StuName.count <= 2 {
            self.name?.text = model.StuName
        }else{
            self.name?.text = model.StuName.cGetindexToEnd(index: model.StuName.count - 2)
        }
        self.name?.backgroundColor = randomColor
        self.info?.text = model.HomeworkTitle.urlDecoded()
        self.aptitle?.text = model.StuName + "的作业"
    }
    
    func cellformodel(model:Model_TestPaper)  {
        self.time?.text = ""
        if model.StuName.count <= 2 {
            self.name?.text = model.StuName
        }else{
            self.name?.text = model.StuName.cGetindexToEnd(index: model.StuName.count - 2)
        }
        self.name?.backgroundColor = randomColor
        self.info?.text = model.ExamName
        self.aptitle?.text = model.StuName + "的试卷"
    }
    
}
