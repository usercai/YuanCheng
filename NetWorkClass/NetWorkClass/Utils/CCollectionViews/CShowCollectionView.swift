//
//  CCollectionView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImageViewer


class CShowCollectionView: UIView {

    let collectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout.init())
    var isshow = false
    
    var dataSource:[String] = []

    var showImage:[DataItem] = []

    private var cellbackcolor = BackBlueColor
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "CImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CImageCollectionViewCell")
        self.collectionView.backgroundColor = UIColor.white
        
        self.addSubview(self.collectionView)
        
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longtap))
        
        self.collectionView.addGestureRecognizer(long)
        
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 60, height: 60)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        self.collectionView.collectionViewLayout = layout
        

        
        
    }
    
    @objc func longtap() {
        
        self.isshow = true
    }
    
    func setDataSource(images:[String])  {
        self.dataSource = images
        self.collectionView.reloadData()
    }
    
    func setcellBackColor(color:UIColor) {
        self.cellbackcolor = color
        self.collectionView.reloadData()
    }
    
}

extension CShowCollectionView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CImageCollectionViewCell", for: indexPath) as! CImageCollectionViewCell
        cell.ImageBig(isOn: true)
        cell.cimage?.c_setImage(url: self.dataSource[indexPath.row])
        cell.delete.isHidden = !self.isshow
        cell.cimage.layer.borderWidth = 1
        cell.cimage.layer.cornerRadius = 5
        cell.backgroundColor = self.cellbackcolor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
}

