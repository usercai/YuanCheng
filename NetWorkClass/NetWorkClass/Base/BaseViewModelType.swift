//
//  BaseViewModelType.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

protocol BaseViewModelType{
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
