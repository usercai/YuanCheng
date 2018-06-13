//
//  LessonTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var dian: UIView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var lesson: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dian.setLayer(cornerRadius: self.dian.c_w/2, linecolorcolor: TINTCOLOR, linewidth: 0, ReacCorner: .all)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func cellforRow(model:Model_Lesson){
        
        self.lesson?.text = model.Title
    }
    
    func islast(islast:Bool){

        line.isHidden = islast
    }
}
