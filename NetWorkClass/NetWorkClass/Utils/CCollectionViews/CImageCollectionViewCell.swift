//
//  CImageCollectionViewCell.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImageViewer

class CImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var delete: UIImageView!
    @IBOutlet weak var cimage: UIImageView!
    var showImage:[DataItem]=[]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cimage.setLayerForNormal(cornerRadius: 5, linecolorcolor: TINTCOLOR, linewidth: 1)
        self.cimage.isUserInteractionEnabled = true
        self.cimage.contentMode = .scaleAspectFill
        

    }

    func ImageBig(isOn:Bool) {
        if isOn == true {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapclick))
            self.cimage.addGestureRecognizer(tap)
        }
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        
        
    }
    
    @objc func tapclick() {

        
        self.showImage = AppTool.setImageForDataItem(images: [self.cimage])
        
        let viewcontroller = GalleryViewController.init(startIndex: 0, itemsDataSource: self, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: AppTool.galleryConfiguration())
        
        AppTool.currentViewController()?.presentImageGallery(viewcontroller)
    }
}

extension CImageCollectionViewCell:GalleryItemsDataSource{
    func itemCount() -> Int {
        return self.showImage.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        
        let item = self.showImage[index].galleryItem
        return item
        
    }
}
