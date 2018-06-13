//
//  CCacheTool.swift
//  NetWorkClass
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class CCacheTool: NSObject {

    override init() {
        super.init()
        
    }
    
    class func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        //缓存目录路径
        
        // 取出文件夹下所有文件数组
        
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        
        var size = 0
        
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            
            let path = (cachePath! as NSString).appending("/\(file)")
            
            // 取出文件属性
            
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            
            // 用元组取出文件大小属性
            
            for (abc, bcd) in floder {
                
                // 累加文件大小
                
                if abc == FileAttributeKey.size {
                    
                    size += (bcd as AnyObject).integerValue
                    
                }
                
            }
            
        }
        
        let mm = size / 1024 / 1024
        
        return mm
        
    }
    
    class func clearCache() -> Bool{
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        var result = true
        let cache = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = cache.first
        // 取出文件夹下所有文件数组
        
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        
        for file in fileArr! {
            
            let path = (cachePath! as NSString).appending("/\(file)")
            
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    
                    try FileManager.default.removeItem(atPath: path)

                } catch {
                    
                    
                    
                }
                
            }
            
        }
        return result
    }
}
