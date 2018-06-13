//
//  QuestionTypeTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class QuestionTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeimage: UIButton!
    @IBOutlet weak var typelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.typelabel.backgroundColor = UIColor.black.alpha(0.5)
        self.typelabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.typelabel.isUserInteractionEnabled = true
        self.typeimage.setLayer(cornerRadius: 5, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        self.typelabel.setLayer(cornerRadius: 5, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)

    }

    func cellForModel(model:Model_ExercisesType)  {
        self.typelabel?.text = model.TypeName
        let type = model.FixedType.typeforTextType()
        switch type {
        case .Duoxuan,.Danxuan,.Panduan:
            self.typeimage.setBackgroundImage(#imageLiteral(resourceName: "xuanzeback"), for: .normal)
        default:
            self.typeimage.setBackgroundImage(#imageLiteral(resourceName: "tiankongback"), for: .normal)
        }
    }
    
}
