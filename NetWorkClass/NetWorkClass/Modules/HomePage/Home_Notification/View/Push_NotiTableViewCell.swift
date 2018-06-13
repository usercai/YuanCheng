//
//  Push_NotiTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/10.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Push_NotiTableViewCell: UITableViewCell {

    @IBOutlet weak var pushtime: UILabel!
    @IBOutlet weak var pushinfo: UILabel!
    @IBOutlet weak var pushTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellforModel(model:Model_PushList)  {
        self.pushinfo?.text = model.SendContent
        self.pushtime?.text = model.CreateDateTime.timeString()
    }
    
}
