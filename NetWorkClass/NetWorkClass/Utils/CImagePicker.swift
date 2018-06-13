//
//  CImagePicker.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import ImagePicker

class CImagePicker: NSObject {
    
    typealias block = ([UIImage])->()
    fileprivate var SelectIamge:block? = nil
    
    let configuration:Configuration = {
        var configuration = Configuration()
        configuration.doneButtonTitle = "Finish"
        configuration.noImagesTitle = "Sorry! There are no images here!"
        configuration.recordLocation = false
        return configuration
    }()
    var imagepicker:ImagePickerController? = nil
    
    convenience init(maxSelectNum:Int) {
        self.init()
        
        self.imagepicker = ImagePickerController(configuration: self.configuration)
        self.imagepicker?.imageLimit = maxSelectNum
//        self.imagepicker?.delegate = self
//        self.SelectIamge = images

    }

    func show(ViewController:UIViewController) {
        ViewController.present(self.imagepicker!, animated: true, completion: nil)
    }
    
}

extension CImagePicker:ImagePickerDelegate{
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.imagepicker!.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        self.imagepicker!.dismiss(animated: true, completion: nil)
        self.SelectIamge!(images)
    }
}
