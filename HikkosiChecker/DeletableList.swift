//
//  DeletableList.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/14.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
struct DeletableList{
    var task:String
    var index:IndexPath
    var flag:Bool
    init(_ task:String,_ index:IndexPath,_ flag:Bool){
        self.task = task
        self.index = index
        self.flag = flag
    }
}
