//
//  ChapterTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var chapter: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var jiahao: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func cellforModel(model:Model_Chapter)  {
        
        self.chapter?.text = model.Title
    }
}
