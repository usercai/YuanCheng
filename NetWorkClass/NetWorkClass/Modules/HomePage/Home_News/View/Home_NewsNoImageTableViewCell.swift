//
//  Home_NewsNoImageTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/24.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Home_NewsNoImageTableViewCell: UITableViewCell {
    @IBOutlet weak var jianju: NSLayoutConstraint!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = .zero
        self.layoutMargins = .zero
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellforModel(model:Model_HomeView)  {
        
        self.title?.text = model.Title
        self.info?.text = model.Author
        self.time?.text = model.CreateDateTime.timeYearMonthDay()
        if model.Author.count == 0 {
            self.jianju.constant = 0
        }
    }
    
}
