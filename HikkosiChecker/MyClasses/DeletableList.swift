//
//  DeletableList.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/14.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
struct DeletableList{   //削除可能なタスクを表す
    var task:String   //タスクのタイトル
    var index:IndexPath  //タスクの格納場所
    var flag:Bool  //チェックされていなければture、チェックされていればfalse
    init(_ task:String,_ index:IndexPath,_ flag:Bool){
        self.task = task
        self.index = index
        self.flag = flag
    }
}
