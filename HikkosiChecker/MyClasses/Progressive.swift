//
//  Progressive.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/22.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
struct Progressive{              //progressViewのデータ格納と、UserDeaultsからの保存、読み込みするクラス
    var ratio:Float = 0.0
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
        UserDefaults.standard.set(moveoutTasksCount,forKey:"moveoutTasksCount")
        UserDefaults.standard.set(didmoveoutTasksCount,forKey:"didmoveoutTasksCount")
        UserDefaults.standard.set(didAddressCount, forKey: "didAddressCount")
        UserDefaults.standard.set(allAddressCount, forKey: "allAddressCount")
        UserDefaults.standard.set(moveinTasksCount, forKey: "moveinTasksCount")
        UserDefaults.standard.set(didmoveinTasksCount, forKey: "didmoveinTasksCount")
    }
    mutating func read(){
        if(UserDefaults.standard.object(forKey: "moveinTasksCount") != nil){ //データがなくてもnilを代入したくない
        self.moveinTasksCount = UserDefaults.standard.object(forKey: "moveinTasksCount") as! Int
        self.didmoveinTasksCount = UserDefaults.standard.object(forKey: "didmoveinTasksCount") as! Int
        self.moveoutTasksCount = UserDefaults.standard.object(forKey:"moveoutTasksCount" ) as! Int
        self.didmoveoutTasksCount = UserDefaults.standard.object(forKey:"didmoveoutTasksCount") as! Int
        self.allAddressCount = UserDefaults.standard.object(forKey: "allAddressCount") as! Int
        self.didAddressCount = UserDefaults.standard.object(forKey: "didAddressCount") as! Int
        }
    }
    func resetKey(){
        UserDefaults.standard.removeObject(forKey: "moveinTasksCount")
        UserDefaults.standard.removeObject(forKey: "didmoveinTasksCount")
        UserDefaults.standard.removeObject(forKey:"moveoutTasksCount" )
        UserDefaults.standard.removeObject(forKey:"didmoveoutTasksCount")
        UserDefaults.standard.removeObject(forKey: "allAddressCount")
        UserDefaults.standard.removeObject(forKey: "didAddressCount")
    }
    mutating func resetData(){
        self.ratio = 0.0
        self.moveoutTasksCount = 0
        self.didmoveoutTasksCount = 0
        self.didAddressCount = 0
        self.allAddressCount = 0
        self.moveinTasksCount = 0
        self.didmoveinTasksCount = 0
    }
    mutating func setRatio(){
        if(moveoutTasksCount+didmoveoutTasksCount+moveinTasksCount+didmoveinTasksCount+allAddressCount == 0){
            ratio = 0
        }else{
        ratio = Float(didAddressCount+didmoveoutTasksCount+didmoveinTasksCount)/Float(moveoutTasksCount+didmoveoutTasksCount+moveinTasksCount+didmoveinTasksCount+allAddressCount)
        }
    }
}
