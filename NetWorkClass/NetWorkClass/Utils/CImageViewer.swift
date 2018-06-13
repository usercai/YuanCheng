//
//  CImageViewer.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImageViewer

class CImageViewer: NSObject {

    static let shared = CImageViewer()
    fileprivate var viewer:GalleryViewController? = nil
    fileprivate var showImages:[DataItem] = []
    private override init() {
        super.init()
        self.initView()
    }
    
    private func initView() {

        
    }
    public func showViewer(images:[UIImageView]) {
        self.showImages = AppTool.setImageForDataItem(images: images)
        self.viewer = GalleryViewController(startIndex: 0, itemsDataSource: self, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: AppTool.galleryConfiguration())
        self.viewer?.reload(atIndex: 0)
        AppTool.currentViewController()?.presentImageGallery(self.viewer!)
    }
    
}

extension CImageViewer:GalleryItemsDataSource{
    func itemCount() -> Int {
        
        return self.showImages.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        
        let item = self.showImages[index].galleryItem
        return item
        
    }
    
    
    
}
