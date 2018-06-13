//
//  Home_NewsTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import SDWebImage
class Home_NewsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var jianju: NSLayoutConstraint!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var infolabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var Headimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func cellforModel(model:Model_HomeView)  {

        self.Headimage.c_setImage(url: model.Picture)
        self.titleLabel?.text = model.Title
        self.infolabel?.text = model.Author
        self.time?.text = model.CreateDateTime.timeYearMonthDay()
        if model.Author.count == 0 {
            self.jianju.constant = 0
        }
    }
}
