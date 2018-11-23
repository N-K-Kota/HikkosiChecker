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
    let key = "Ratio"
    init(_ ratio:Float){
        self.ratio = ratio
    }
    func save(){
        UserDefaults.standard.set(ratio, forKey: key)
    }
    func read(){
        if let r = UserDefaults.standard.object(forKey: key){
            ratio = r as! Float
        }
    }
}
