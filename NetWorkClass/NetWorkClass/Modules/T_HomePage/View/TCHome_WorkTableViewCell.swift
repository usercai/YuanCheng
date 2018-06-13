//
//  TCHome_WorkTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TCHome_WorkTableViewCell: UITableViewCell {

    @IBOutlet weak var tralingline: UIView!
    @IBOutlet weak var bottomline: UIView!
    @IBOutlet weak var leadingline: UIView!
    @IBOutlet weak var topline: UIView!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var nametitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        
        // Initialization code
    }

    func cellformodel(model:Model_HomeWork,row:Int)  {
        self.nametitle.text = "作业" + (row+1).string() + ": "  + model.HomeworkTitle.urlDecoded()
        
    }

    func firstCell() {
        self.bottomline.isHidden = true
        self.topline.isHidden = false
    }
    
    func endCell(){
        self.bottomline.isHidden = false
        self.topline.isHidden = true
    }
    
    func normalCell() {
        self.bottomline.isHidden = true
        self.topline.isHidden = true
    }
    func oneCell() {
        self.bottomline.isHidden = false
        self.topline.isHidden = false

    }
    
}
