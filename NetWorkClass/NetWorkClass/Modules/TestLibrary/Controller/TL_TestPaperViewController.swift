//
//  TL_TestPaperViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

/// ScrollView方案  废弃
class TL_TestPaperViewController: BaseViewController {

    let scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        scroll.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    let viewmodel = TL_TestPaperInfoViewModel()
    var index = 0
    var examId = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    convenience init(examId:Int) {
        self.init()
        self.examId = examId
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initView(){
        
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
    }
    
    func initTestData() {
        let output = self.viewmodel.getDataList(examID: self.examId, index: self.index)
        output.models.asDriver().drive(onNext: { (models) in
            
            if models.count != 0{

                
                
            }
            
            
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(.first)
    }

}
extension TL_TestPaperViewController:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        self.index = page
        
        
        
    }
}
