//
//  HomeWork_SubjectTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class HomeWork_SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var back: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var xuhao: UILabel!

    let color = [["#ff8a28","#fea964","#fdc596"],["#2ca5ff","#5cb9fd","#8acdfd"],["#ff545c","#fe8188","#ffabae"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

    override func layoutSubviews() {

        self.back.layoutIfNeeded()
        
        self.xuhao.setLayer(cornerRadius: self.xuhao.c_w/2, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        self.back.setLayer(cornerRadius: self.xuhao.c_w/2, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        
        setColor(array: color[1])

    }

    func setColor(array:[String]) {
        self.xuhao.backgroundColor = UIColor.init(hex: array[0])

        color(start: UIColor.init(hex: array[1]).cgColor, end: UIColor.init(hex: array[2]).cgColor)

    }
    func cellformodel(model:Model_Work)  {

        self.name?.text = model.SubjectName
    }
    
    func cellformodel(model:Model_GradeSubject)  {
        self.name?.text = model.GradeName + model.SubjectName
    }
//
//    override func layoutSublayers(of layer: CALayer) {
//
//        
//    }
    
    func color(start:CGColor,end:CGColor) {
        
        let layer:CAGradientLayer = CAGradientLayer()
        layer.colors = [start,end]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.frame = CGRect(x: 0, y: 0, width: self.back.c_w, height: self.back.c_h)
        self.back.layer.insertSublayer(layer, at: 0)
    }
    
}
