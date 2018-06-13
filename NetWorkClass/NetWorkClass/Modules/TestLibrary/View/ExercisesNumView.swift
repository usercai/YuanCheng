//
//  ExercisesNumView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class ExercisesNumView: UIView {

    typealias didSelect = (_ index:Int)->Void
    
    private var collection:UICollectionView? = nil
    
    var selectIndex = 0
    
    
    init(frame: CGRect,Count:Int) {
        super.init(frame: frame)
        self.count = Count
        initView()
        
        
    }
    
    var count = 0

    
    var didSelectItem:didSelect? = nil
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView()  {
        
        self.backgroundColor = WHITEColor
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 50, height: self.c_h)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection?.backgroundColor = WHITEColor
        self.collection?.register(UINib.init(nibName: "QuestionTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuestionTypeCollectionViewCell")
        self.addSubview(self.collection!)
        
    }
    
    func setSelectItem(item:Int){
        
        self.selectIndex = item
        self.collection?.reloadData()
    }
}

extension ExercisesNumView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return Int(self.count/10) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionTypeCollectionViewCell", for: indexPath) as! QuestionTypeCollectionViewCell
        if indexPath.item == Int(self.count/10){
            cell.numberlabel.text = (indexPath.item*10 + 1).string() + "~" + (self.count%10 + indexPath.item*10).string()
        }else{
            cell.numberlabel.text = (indexPath.item*10 + 1).string() + "~" + (indexPath.item*10 + 10).string()
        }
        
        if indexPath.item == self.selectIndex {
            
            cell.selectCell()
        }else{
            cell.normalCell()
        }
        
        cell.backgroundColor = WHITEColor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.didSelectItem?(indexPath.row)
        collectionView.reloadData()

        self.selectIndex = indexPath.item

        
    }
    
}
