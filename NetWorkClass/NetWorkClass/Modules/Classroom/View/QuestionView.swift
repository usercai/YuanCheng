//
//  QuestionView.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tiwen: UIButton!
    @IBOutlet weak var tijiao: UIButton!
    @IBOutlet weak var quxiao: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backview: UIView!
    
    override func awakeFromNib() {
        
        self.segment.selectedSegmentIndex = 0
        self.backview.layer.borderColor = TINTCOLOR.cgColor
        self.backview.layer.borderWidth = 1
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            print("000")
        default:
            print("111")
        }
    }
    
}
