
//
//  Mov.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/22.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class UncheckedObj:Object{                //チェックされていないリストのオブジェクト
    var sectionobjList:List<Sectionobj> = List<Sectionobj>()
    func returnSectionobjsCount()->Int{
        var n = 0
        for i in sectionobjList{
            if(i.taskList.count != 0){
                n += 1
            }
        }
        return n
    }
    func taskCount()->Int{               //タスクの数を返す
        var n = 0
        for i in sectionobjList{
           n += i.taskList.count
        }
        return n
    }
}
class CheckedObj:Object{     //チェックされたリストのオブジェクト
    var sectionobjList:List<Sectionobj> = List<Sectionobj>()
    @objc dynamic var watchable:Bool = false   //表示するか非表示にするかのフラグ
    func taskCount()->Int{                     //タスクの数を返す
        var n = 0
        for i in sectionobjList{
            n += i.taskList.count
        }
        return n
    }
}
class Sectionobj:Object{                 //セクションのオブジェクト
    var taskList = List<Task>()
    @objc dynamic var title:String = ""
}
class Task:Object{                       //タスクのオブジェクト
    @objc dynamic var task:String  = ""
    @objc dynamic var point:String = ""
    @objc dynamic var requirement:String = ""
    @objc dynamic var memo:String? = nil
    @objc dynamic var canRemove:Bool = false
}

struct RatioDatasource{                            //完了した作業の割合を返すだけ（現在は転出作業のみ)
   static func returnRatio(uncheckedTaskCount:
    Int,checkedTaskCount:Int,adressTaskCount:Int,checkedAdressTask:Int)->Float{
        return Float(checkedTaskCount+checkedAdressTask)/Float(uncheckedTaskCount+checkedTaskCount+adressTaskCount)
    }
}
