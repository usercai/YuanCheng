//
//  MyCalendarTitleView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class MyCalendarTitleView: UIView {
    
    lazy var centerView:UIView = {
        
        let centerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        centerView.center = self.center
        return centerView
    }()
    
    var lastbtn : UIButton?
    var nextbtn : UIButton?
    var titletext : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension MyCalendarTitleView{
    
    func initView() {
        
        
        
        self.lastbtn = UIButton()
        self.nextbtn = UIButton()
        self.titletext = UILabel()
        self.centerView.backgroundColor = CalenderBack
        self.centerView.setLayer(cornerRadius: 15, linecolorcolor: TINTCOLOR, linewidth: 0, ReacCorner: .all)
        self.centerView.center = self.center
        
        self.lastbtn?.frame = CGRect.init(x: 15, y: 0, width: 30, height: 30)
        self.titletext?.frame = CGRect(x: (self.lastbtn?.frame.maxX)!, y: 0, width: 110, height: self.centerView.frame.height)
        self.nextbtn?.frame = CGRect.init(x: (self.titletext?.frame.maxX)!, y: 0, width: 30, height: 30)
        self.titletext?.textAlignment = .center
        self.titletext?.font = UIFont.systemFont(ofSize: 12)
        self.titletext?.textColor = WHITEColor
        
        let lastimage = UIImageView.init(image: #imageLiteral(resourceName: "arrows_leftwhite"))
        let nextimage = UIImageView.init(image: #imageLiteral(resourceName: "arrows_rightwhite"))
        lastimage.frame = CGRect.init(x: 12, y: (self.lastbtn?.center.y)!-6, width: 6, height: 12)
        nextimage.frame = CGRect(x: 12, y: (self.nextbtn?.center.y)! - 6, width: 6, height: 12)
        
        self.lastbtn?.addSubview(lastimage)
        self.nextbtn?.addSubview(nextimage)
        
        self.addSubview(self.centerView)
        self.centerView.addSubview(lastbtn!)
        self.centerView.addSubview(nextbtn!)
        self.centerView.addSubview(titletext!)
        
        self.lastbtn?.addTarget(self, action: #selector(lastmonth), for: .touchUpInside)
        self.nextbtn?.addTarget(self, action: #selector(nextmonth), for: .touchUpInside)
        
        
    }
    
    @objc func lastmonth() {
        
        
    }
    
    
    @objc func nextmonth() {
        
    }
    
}




