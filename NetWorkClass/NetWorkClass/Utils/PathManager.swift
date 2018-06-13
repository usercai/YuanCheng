//
//  PathManager.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import PathKit

class PathManager: NSObject {

    class func FilePathisNull(path:String) -> URL? {
        var p = ""
        
        if path.contains("/") {
            p = path.components(separatedBy: "/").last ?? ""
        }
        
        let docpath = Path(p)
        
        let basepath = Path(getDocumentPath())
        
        let rightpath = basepath + docpath
        
        let ispath = rightpath.exists
        
        print(rightpath.url.path)
        print("+++++++++++++++++")
        return ispath ? rightpath.url : nil
    }
    
    class func getDocumentPath() -> String {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .cachesDirectory, in:.userDomainMask)
        let url = urlForDocument.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        
        return url.path
    }
    
    
    

    
}
