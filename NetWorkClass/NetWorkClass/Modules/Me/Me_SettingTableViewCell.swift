//
//  Me_SettingTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class Me_SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var titletext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userimage.layer.cornerRadius = self.userimage.c_w/2
        userimage.clipsToBounds = true
        
        userimage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        userimage.addGestureRecognizer(tap)
        self.selectionStyle = .none

        // Initialization code
    }
    
    @objc func tapClick() {
        
        CImageViewer.shared.showViewer(images: [self.userimage])
    }

    
}



