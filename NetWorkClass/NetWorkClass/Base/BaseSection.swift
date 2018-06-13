//
//  BaseSection.swift
//  SwiftFrame
//
//  Created by mac on 2017/11/17.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit
import RxDataSources
import ObjectMapper

struct BaseSection{
    var items : [Item]
    
}

extension BaseSection:SectionModelType  {
    typealias Item = BaseMappable
    
    init(original:BaseSection ,items:[BaseSection.Item]) {
        self = original
        self.items = items
    }
}
