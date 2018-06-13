//
//  TL_TestPaperScrollViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import PageMenu

/// collection方案放弃
class TL_TestPaperScrollViewController: BaseViewController {

    var index = 0
    
    var examId = 0
    
    var collectionView : UICollectionView? = nil
    
    var currentPage = 0
    
    var isfirst = true
    var swip = TL_TestPaperInfoViewModel.swip.first
    let viewmodel = TL_TestPaperInfoViewModel()
    var dict:[String:Model_Danxuan] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTestData()
    }
    
    convenience init(examId:Int) {
        self.init()
        self.examId = examId
    }
    
    override func initView() {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: SCREEN_WIDTH, height: self.view.c_h - 64)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 1, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView?.scrollsToTop = false
        self.extendedLayoutIncludesOpaqueBars = false
        self.collectionView!.register(TestPaperCollectionViewCell.self, forCellWithReuseIdentifier: "TestPaperCollectionViewCell")
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.isPagingEnabled = true
        self.view.addSubview(self.collectionView!)
        
        
    }
    
    
    func initTestData() {
        let output = self.viewmodel.getDataList(examID: self.examId, index: self.index)
        output.models.asDriver().drive(onNext: { (models) in
            
            if models.count != 0{
//                if self.isfirst == true{
                    self.dict[self.index.string()] = models.first!
                    self.collectionView?.reloadItemsAtIndexPaths([IndexPath.init(row: self.index, section: 0)], animationStyle: UITableViewRowAnimation.right)
//                }
                self.isfirst = false

            }


            
        }, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        output.requestCommond.onNext(.first)
    }
    

    
    
    
}

extension TL_TestPaperScrollViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestPaperCollectionViewCell", for: indexPath) as! TestPaperCollectionViewCell

        if self.dict.keys.contains(indexPath.row.string()) == true && indexPath.row == self.index{
            cell.cellForModel(model: self.dict[indexPath.row.string()]!)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)

        self.index = page
        self.isfirst = true
        self.initTestData()
        
        print(page)
    }
    
    

}
