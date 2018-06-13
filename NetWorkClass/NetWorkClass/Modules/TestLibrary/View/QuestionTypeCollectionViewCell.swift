//
//  QuestionTypeCollectionViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class QuestionTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.numberlabel.setLayer(cornerRadius: 3, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
    }
    
    func selectCell() {
        self.numberlabel?.backgroundColor = TINTCOLOR
        self.numberlabel?.textColor = WHITEColor
    }
    
    func normalCell() {
        self.numberlabel?.backgroundColor = WHITEColor
        self.numberlabel?.textColor = TextColor
    }

}
