
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

class UncheckedObj:Object{
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
    func taskCount()->Int{
        var n = 0
        for i in sectionobjList{
           n += i.taskList.count
        }
        return n
    }
}
class CheckedObj:Object{
    var sectionobjList:List<Sectionobj> = List<Sectionobj>()
    @objc dynamic var watchable:Bool = false
    func taskCount()->Int{
        var n = 0
        for i in sectionobjList{
            n += i.taskList.count
        }
        return n
    }
}
class Sectionobj:Object{
    var taskList = List<Task>()
    @objc dynamic var title:String = ""
}
class Task:Object{
    @objc dynamic var task:String  = ""
    @objc dynamic var point:String = ""
    @objc dynamic var requirement:String = ""
    @objc dynamic var memo:String? = nil
    @objc dynamic var canRemove:Bool = false
}

struct RatioDatasource{
   static func returnRatio(uncheckedTaskCount:
        Int,checkedTaskCount:Int)->Float{
        return Float(checkedTaskCount)/Float(uncheckedTaskCount+checkedTaskCount)
    }
}
