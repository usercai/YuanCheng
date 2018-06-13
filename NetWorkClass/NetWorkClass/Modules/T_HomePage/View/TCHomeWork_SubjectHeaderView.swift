//
//  TCHomeWork_SubjectHeaderView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxSwift
class TCHomeWork_SubjectHeaderView: UITableViewHeaderFooterView {
    
    public var headLabel:UILabel = UILabel()
    var contentLabel:UILabel = UILabel()
    private var image:UIImage = UIImage()
    private var titletext:UILabel = UILabel()
    public var buzhibtn:UIButton = UIButton()
    private var jiantou:UIImageView = UIImageView()
    var mycolor = ["#2ca5ff","#5cb9fd","#8acdfd"]
    let dis = DisposeBag()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    func initView() {
        
//        let temp = Int(arc4random()%3)
//        self.mycolor = color[temp]
        self.backgroundColor = UIColor.white
        
        self.contentLabel.frame = CGRect.init(x: 20, y: 5, width: SCREEN_WIDTH - 40, height: 30)
        self.contentLabel.backgroundColor = TINTCOLOR
        self.contentLabel.setLayer(cornerRadius: 15, linecolorcolor: nil, linewidth: nil, ReacCorner: .all)
        self.contentLabel.isUserInteractionEnabled = true
        self.addSubview(contentLabel)
        self.setColor(array: self.mycolor)
        
        
        self.headLabel.frame = CGRect.init(x: 0, y: 0, width: self.contentLabel.c_h, height: self.contentLabel.c_h)
        self.headLabel.setLayer(cornerRadius: 15, linecolorcolor: nil, linewidth: nil, ReacCorner: .all)
        self.headLabel.textAlignment = .center
        self.headLabel.textColor = WHITEColor
        self.headLabel.font = CFont_12
        self.contentLabel.addSubview(self.headLabel)
        
        self.titletext.frame = CGRect.init(x: self.headLabel.c_maxX() + 10, y: 0, width: 150, height: self.contentLabel.c_h)
        self.titletext.textColor = WHITEColor
        self.titletext.font = CFont_12
        self.contentLabel.addSubview(self.titletext)
        
        self.buzhibtn.setBackgroundImage(#imageLiteral(resourceName: "buzhijiahao"), for: .normal)
        self.buzhibtn.titleLabel?.font = CFont_12
        self.buzhibtn.setTitleColor(tintColor, for: UIControlState.normal)
        self.buzhibtn.setLayerForNormal(cornerRadius: 12)
        self.contentLabel.addSubview(self.buzhibtn)
        
        self.jiantou.frame = CGRect(x: self.contentLabel.c_maxX() - 48, y: 3, width: 24, height: 24)
        self.jiantou.image = #imageLiteral(resourceName: "jinatou_blue")
        self.jiantou.setLayerForNormal(cornerRadius: 12)
        self.contentLabel.addSubview(self.jiantou)
        
        self.buzhibtn.frame = CGRect.init(x: self.jiantou.c_x - 44, y: 3, width: 24, height: 24)

        
    }
    
    func cellForModel(model:Model_GradeSubject)  {
        
        self.titletext.text = model.GradeName + model.SubjectName
    }
    
    
    func setColor(array:[String]) {
        self.headLabel.backgroundColor = UIColor.init(hex: array[0])
        color(start: UIColor.init(hex: array[1]).cgColor, end: UIColor.init(hex: array[2]).cgColor)
    }
    
    
    func color(start:CGColor,end:CGColor) {
        
        let layer:CAGradientLayer = CAGradientLayer()
        layer.colors = [start,end]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.frame = CGRect(x: 0, y: 0, width: self.contentLabel.c_w, height: self.contentLabel.c_h)
        self.contentLabel.layer.insertSublayer(layer, at: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
