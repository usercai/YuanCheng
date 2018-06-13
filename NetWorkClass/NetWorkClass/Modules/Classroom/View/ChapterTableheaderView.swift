//
//  ChapterTableheaderView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ChapterTableheaderView: UIView {

    @IBOutlet weak var jiahao: UIImageView!
    @IBOutlet weak var chapter: UILabel!
    @IBOutlet weak var line: UIView!

    


    
    static func newInstance() -> ChapterTableheaderView?{
        let nibView = Bundle.main.loadNibNamed("ChapterTableheaderView", owner: nil, options: nil)?.last
        if let nib = nibView as? ChapterTableheaderView{
            return nib
        }
        return nil
    }

    func sectionType(isSelect:Bool)  {
        if isSelect == true {
            self.line.isHidden = false
            self.jiahao.image = #imageLiteral(resourceName: "jianhao")
        }else{
            self.line.isHidden = true
            self.jiahao.image = #imageLiteral(resourceName: "jiahao")
        }
    }

    func sectionforModel(model:Model_Chapter)  {
        self.chapter?.text = model.Title
    }
    
    
    
}
