//
//  FileTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    @IBOutlet weak var filename: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.filename.setLayerForNormal(cornerRadius: 3)
        // Initialization code
//        self.filename.setLayer(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 0, ReacCorner: .all)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


