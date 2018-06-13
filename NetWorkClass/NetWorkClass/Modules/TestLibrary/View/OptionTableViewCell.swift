//
//  OptionTableViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/28.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var textinfo: UILabel!
    @IBOutlet weak var xuanxiang: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.xuanxiang.setLayerForNormal(cornerRadius: self.xuanxiang.c_w/2, linecolorcolor: TINTCOLOR, linewidth: 1)
    }
    
    func cellforModel(model:Model_DanxuanBody){
        
        self.textinfo?.text = model.OptionValue
    }
    
    func selectCell(){
        self.xuanxiang?.backgroundColor = TINTCOLOR
        self.xuanxiang?.setTitleColor(WHITEColor, for: .normal)
    }
    
    func normalCell(){
        self.xuanxiang?.backgroundColor = WHITEColor
        self.xuanxiang?.setTitleColor(UIColor.black, for: .normal)
        self.xuanxiang?.setImage(nil, for: .normal)
    }
    func rightCell()  {
        self.xuanxiang?.setImage(#imageLiteral(resourceName: "ic_right"), for: .normal)
        self.xuanxiang?.setTitle(nil, for: .normal)

    }
    func errorCell() {
        self.xuanxiang?.setImage(#imageLiteral(resourceName: "ic_error"), for: .normal)
        self.xuanxiang?.setTitle(nil, for: .normal)
//        self.xuanxiang?.backgroundColor = UIColor.red
    }
}
