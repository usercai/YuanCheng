//
//  Me_SettingTestTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Me_SettingTestTableViewCell: UITableViewCell {
    @IBOutlet weak var infotext: UILabel!
    @IBOutlet weak var titletext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
}

