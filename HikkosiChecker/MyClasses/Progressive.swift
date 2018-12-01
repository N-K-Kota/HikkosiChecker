//
//  Progressive.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/22.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
class Progressive{              //progressViewのデータ格納と、UserDeaultsからの保存、読み込みするクラス
    var ratio:Float = 0.0
    static let key = "Ratio"
    var moveoutTasksCount = 0
    var didmoveoutTasksCount = 0
    var didAddressCount = 0
    var allAddressCount = 0
    var moveinTasksCount = 0
    var didmoveinTasksCount = 0
    init(_ ratio:Float){
        self.ratio = ratio
    }
    func save(){
        UserDefaults.standard.set(ratio, forKey: Progressive.key)
    }
    func read(){
        if let r = UserDefaults.standard.object(forKey: Progressive.key){
            ratio = r as! Float
        }
    }
    func setRatio(){
        if(moveoutTasksCount+didmoveoutTasksCount+moveinTasksCount+didmoveinTasksCount+allAddressCount == 0){
            ratio = 0
        }else{
        ratio = Float(didAddressCount+didmoveoutTasksCount+didmoveinTasksCount)/Float(moveoutTasksCount+didmoveoutTasksCount+moveinTasksCount+didmoveinTasksCount+allAddressCount)
        }
    }
}
