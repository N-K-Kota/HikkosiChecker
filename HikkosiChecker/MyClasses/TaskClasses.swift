
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

class MoveinList:Object{
    var taskList = List<Task>()
    func taskCount()->Int{               //タスクの数を返す
        return taskList.count
    }
    func dataInit(taskKey:TaskKey){
        let realm = try! Realm()
        let datas = [   //[タイトル,ポイント,持ち物]
            ["免許の書き換え","お近くの警察署、運転免許更新センター、運転免許試験場で手続きができます。\n新しい住所を証明できるものがあれば手続きできますが、マイナンバーの通知カードではできないので注意が必要です。","・運転免許証\n・新しい住所を証明できる物（住民票、健康保険証、公的機関からの郵送物）"],
            ["インターネット回線の契約","",""],
            ["転入届けなどの手続き","原則転入後１４日以内に市役所で手続きをすることとなっているので早めに手続きをすませましょう。\n","・転出証明証\n・マイナンバーカード、通知カード\n・運転免許証（ない場合は本人が確認できるもの）\n・印鑑\n・国民年金手帳（厚生年金に加入していない場合)"],
            ["電気、ガス、水道の契約","電力自由化によって自分にあったプランを選べるようになりました。\nお住いのマンションの契約状況によっては選べない場合もありますが、基本的には契約先を選べるので検討することをお勧めします。",""],
            ["日用品を購入","日常生活に必要なものは忘れずに購入するか準備しておくようにしましょう","・ティッシュペーパー\n・トイレットペーパー\n・歯ブラシ\n・洗濯用洗剤\n・タオル類\n・石鹸、シャンプー"]
        ]
        for i in datas{
            let task = Task()
            task.task = i[0]
            task.point = i[1]
            task.requirement = i[2]
            try! realm.write{
            task.id = taskKey.createKey()
            }
            taskList.append(task)
        }
    }
}
class DidMoveinList:Object{
    var taskList = List<Task>()
    @objc dynamic var watchable:Bool = false   //表示するか非表示にするかのフラグ
    func taskCount()->Int{                     //タスクの数を返す
        return taskList.count
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
    @objc dynamic var id:Int = 0
    override static func primaryKey()->String?{
        return "id"
    }
}

struct RatioDatasource{                            //完了した作業の割合を返すだけ（現在は転出作業のみ)
   static func returnRatio(uncheckedTaskCount:
    Int,checkedTaskCount:Int,adressTaskCount:Int,checkedAdressTask:Int)->Float{
        return Float(checkedTaskCount+checkedAdressTask)/Float(uncheckedTaskCount+checkedTaskCount+adressTaskCount)
    }
}
