//
//  HomeWorkTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class HomeWorkTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageheigth: NSLayoutConstraint!
    @IBOutlet weak var Homeimage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var hometitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellforModel(model:Model_WorkBody){
        
        self.hometitle?.text = model.HomeworkTitle.urlDecoded()
        self.time?.text = model.HomeworkDate.timeString()
        
        self.Homeimage.c_setImage(url: model.HomeworkImg)
        if model.HomeworkImg == ""{
            imageheigth.constant = 0
        }
    }
    
    func cellforModel(model:Model_HomeWork){
        
        self.hometitle?.text = model.HomeworkTitle.urlDecoded()
        self.time?.text = model.HomeworkDate.timeString()
        
//        self.Homeimage.c_setImage(url: model.HomeworkImg)
//        if model.HomeworkImg == ""{
            imageheigth.constant = 0
//        }
    }
    
    func cellforModel(model:Model_QuestionList) {
        self.hometitle?.text = model.Question.urlDecoded()
        self.time?.text = model.CreateTime.compareCurrentTime()
    }
    
}
