//
//  CCollectionView.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImagePicker

class CCollectionView: UIView {

    let collectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout.init())
    var isshow = false
    
    var dataSource:[UIImage] = []
    var urldataSource:[String] = []
    let configuration:Configuration = {
        var configuration = Configuration()
        configuration.doneButtonTitle = "Finish"
        configuration.noImagesTitle = "Sorry! There are no images here!"
        configuration.recordLocation = false
        return configuration
    }()
    
    var imagePicker : ImagePickerController? = nil
    var isBianhua = false
    
    
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
        
        self.imagePicker = ImagePickerController(configuration: self.configuration)
        imagePicker?.delegate = self
        //最多图片数量
        self.imagePicker?.imageLimit = 10
        
    }
    
    @objc func longtap() {
        
//        self.isshow = !self.isshow
//        self.collectionView.reloadData()
    }
    
    func setDataSource(images:[UIImage])  {
        self.dataSource = images
        self.collectionView.reloadData()
    }
    func setDataSource(urls:[String]) {
        self.urldataSource = urls
        self.collectionView.reloadData()
    }
    
}

extension CCollectionView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CImageCollectionViewCell", for: indexPath) as! CImageCollectionViewCell
        
        var count = 0
        if self.urldataSource.count != 0 {
            count = self.urldataSource.count
        }else{
            count = self.dataSource.count
        }
        if indexPath.item == count {
            cell.cimage?.image = #imageLiteral(resourceName: "tianjia")
            cell.delete.isHidden = true
            cell.cimage.layer.cornerRadius = 0
            cell.cimage.layer.borderWidth = 0
            cell.ImageBig(isOn: false)

        }else{
            if self.urldataSource.count != 0{
                cell.cimage.c_setImage(url: self.urldataSource[indexPath.item])
            }else{
                cell.cimage?.image = self.dataSource[indexPath.item]

            }
            cell.delete.isHidden = !self.isshow
            cell.cimage.layer.borderWidth = 1
            cell.cimage.layer.cornerRadius = 5
            cell.ImageBig(isOn: true)

        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.urldataSource.count != 0{
            return self.urldataSource.count + 1
        }else{
            return self.dataSource.count + 1

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var count = 0
        if self.urldataSource.count != 0 {
            count = self.urldataSource.count
        }else{
            count = self.dataSource.count
        }
        if indexPath.item == count{
            if self.urldataSource.count != 0 {
                AppTool.showAlert(title: "是否重新上传", QAction: {
                    self.urldataSource.removeAll()
                    AppTool.currentViewController()?.present(self.imagePicker!, animated: true, completion: nil)

                })
            }else{
                AppTool.currentViewController()?.present(self.imagePicker!, animated: true, completion: nil)

            }
        }
    }
}

extension CCollectionView:ImagePickerDelegate{
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        

        self.isBianhua = true
        self.setDataSource(images: images)
        


    }
}
