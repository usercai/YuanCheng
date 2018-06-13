//
//  TestLibraryViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/25.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class TestLibraryViewController: BaseViewController {
//蒙版
    @IBOutlet weak var moniblack: UIView!
    @IBOutlet weak var lixiblack: UIView!
    @IBOutlet weak var moniti: UIButton!
    @IBOutlet weak var lianxiti: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.moniti.setLayer(cornerRadius: 5, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        self.lianxiti.setLayer(cornerRadius: 5, linecolorcolor: UIColor.clear, linewidth: 0, ReacCorner: .all)
        self.moniblack.backgroundColor = UIColor.black.alpha(0.3)
        self.lixiblack.backgroundColor = UIColor.black.alpha(0.3)
        self.lixiblack.setLayerForNormal(cornerRadius: 5)
        self.moniblack.setLayerForNormal(cornerRadius: 5)
        self.lixiblack.isUserInteractionEnabled = true
        self.moniblack.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// 练习题
    ///
    /// - Parameter sender:
    @IBAction func exercisesAction(_ sender: UITapGestureRecognizer) {
        
        let vc = TestLibraraySubjectViewController(Api: TestLibraryApi.QuestionSubjectList(KUserInfo.user.GradeID))
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    /// 模拟题
    ///
    /// - Parameter sender:
    @IBAction func PrecticeAction(_ sender: UITapGestureRecognizer) {
        let vc = TestLibraraySubjectViewController(Api: TestLibraryApi.ExamSubjectList(KUserInfo.user.GradeID))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
