//
//  GradeCollectionViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/27.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class GradeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gradeheigth: NSLayoutConstraint!
    @IBOutlet weak var gradewidth: NSLayoutConstraint!
    @IBOutlet weak var grade: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.grade.setLayerForNormal(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 1)
        
        let text = self.grade?.text ?? ""

        let width = getLabWidth(labelStr: text, font: UIFont.systemFont(ofSize: 12), height: 40)

        self.gradewidth.constant = width + 20
        self.gradeheigth.constant = getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: 12), width: width + 40) + 10

        // Initialization code
    }
    
    
    func cellforModel(model:Model_Grade){
        
        self.grade?.text = model.GradeName
        let text = (self.grade?.text ?? "")

        let width = getLabWidth(labelStr: text, font: UIFont.systemFont(ofSize: 12), height: 40)

        self.gradewidth.constant = width + 40
        let height = getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: 12), width: width + 40) + 10

        self.gradeheigth.constant = height
    }

    func cellforClass(model:Model_Class)  {
        self.grade?.text = model.ClassesName
        let text = (self.grade?.text ?? "")
        
        let width = getLabWidth(labelStr: text, font: UIFont.systemFont(ofSize: 12), height: 40)
        
        self.gradewidth.constant = width + 40
        let height = getLabHeigh(labelStr: text, font: UIFont.systemFont(ofSize: 12), width: width + 40) + 10
        
        self.gradeheigth.constant = height
    }
    
    func SelectCell(isSelect:Bool) {
        if isSelect {
            self.grade?.backgroundColor = TINTCOLOR
            self.grade?.textColor = WHITEColor
        }else{
            self.grade?.backgroundColor = WHITEColor
            self.grade?.textColor = TINTCOLOR
        }

    }
    
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width: width, height: 50)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as! [NSAttributedStringKey : Any], context: nil).size
        var width = strSize.height
        
        if strSize.height > 39 {
            width = 38
        }
        return width
        
    }
    
    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width: (SCREEN_WIDTH-50)/3, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as! [NSAttributedStringKey : Any], context: nil).size
        var width = strSize.width
        
        if strSize.width > 38 {
            width = 38
        }
        return width
        
    }
    

    
}
