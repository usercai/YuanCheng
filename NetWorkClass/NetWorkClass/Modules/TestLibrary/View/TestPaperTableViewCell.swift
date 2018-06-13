
//
//  TestPaperTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TestPaperTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var testpapername: UILabel!
    @IBOutlet weak var read: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellforModel(model:Model_TestPaper) {
     
        
        self.read.isHidden = (model.IsRead == 1)

        self.testpapername?.text = model.ExamName

    }
    func cellforModel(model:Model_HomeWork) {
        
        self.read.isHidden = (model.IsRead == 1)
        self.time.isHidden = false
        self.testpapername.text = model.HomeworkTitle.urlDecoded()
        self.time.text = model.HomeworkDate.compareCurrentTime()
    }
    func cellforModel(model:Model_QuestionList) {
     
        self.read.isHidden = (model.IsRead == 1)

        self.time.isHidden = false
        self.testpapername.text = model.Question.urlDecoded()
        self.time.text = model.CreateTime.compareCurrentTime()
    }
}
