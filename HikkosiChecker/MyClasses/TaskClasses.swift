
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
    func initData(taskKey:TaskKey){
        let task1 = Task()
        task1.task = "持ち物の分類"
        task1.point = "引っ越しを機に不用品を処分するのもいいでしょう。\n売却する場合には、オンラインサービスを使う、リサイクルショップに持ち込む、専門店に持ち込む、などの手段があります。\n"
        task1.id = taskKey.createKey()
        let task2 = Task()
        task2.task = "粗大ゴミの申し込み"
        task2.point = "市区町村によってゴミの出し方、処分費用は変わるので確認しましょう。\n粗大ゴミは月一回しか出せない市区町村も多いので早めに出せる日にちを確認することが必要です。\nクリーンセンターなどに持ち込みをすると費用が抑えられることもありますが、その場合も予約が必要です。"
        task2.id = taskKey.createKey()
        let task3 = Task()
        task3.task = "ゴミ出し曜日の確認"
        task3.point = "自治体によってゴミの出せる曜日は決まっていますので、出し忘れのないように確認をしておきましょう。"
        task3.id = taskKey.createKey()
        let task4 = Task(value:["住居の解約届","だいたい２週間前までには届けないといけないことが多いです。\n届けるのが遅れると余計な家賃がかかってしまうこともあります。",nil,nil,false,taskKey.createKey()])
        let task5 = Task(value:["引っ越し業者を決める","業者によって料金が大きく変わることがあるので複数の業者を比較しましょう。\n一括見積もりサイトを利用すると便利です。",nil,nil,false,taskKey.createKey()])
        let task6 = Task(value:["引越し先の下見、採寸","""
B1☆下見の際のポイント


B2◎日当たり、湿度
日当たりが悪いと室内がカビやすくなったり洗濯物が乾きにくくなったりすることがあります。
 窓の結露をチェックすると湿度が分かりやすいです。

B2◎音が響くか、周囲の音がするか
往来の激しい道路や大きな駅が近くにあると夜間でも騒音がする場合があります。
また一般的に木造製だと防音性が低く、鉄筋コンクリート製は防音性が高いです。
壁の厚さは１８０m以上あるのが好ましいと言われていますので、担当者に聞いたり、できるならば外から音を流して中で響くか確認するのもいいでしょう。

B2◎水回り
お風呂や洗面台にカビは発生してるか、異臭はしないか、つまりはないか、できれば水を流してチェックしましょう。
シャワーの水圧も弱すぎないか見ておくといいです。

B2◎エアコンは設置されているか、内部の状態はどうか
エアコン内部が汚れているとクリーニング代がかかったり、型式が古すぎると交換しないといけないこともあります。費用は大家さんや管理会社が出してくれる場合もありますが、確認しておくと安心です。
自分でエアコンを設置する場合でも勝手に設置することはできないので費用の負担割合、設置可能かどうかは確認しておきましょう。

B2◎コンセントの数と位置
テレビの配線の場所、コンセントの設置場所によってある程度家具の間取りが決まることになります。
また、照明のコンセントの形によってつけられる照明も決まってくるのでカメラで撮影しておくといいでしょう。

B2◎室内の汚れ、傷はあるか
入居後傷を発見した場合は修繕費用の負担を求められることになることがあるので注意が必要です。


B1☆採寸のポイント

家具の購入や搬入の際に困ることがないように採寸、撮影をしておくと便利です。
採寸するべき箇所は以下の通りです

◎通路、ドアの横幅
◎洗濯槽の設置場所の大きさ
◎キッチンのシンクの大きさ
◎天井の高さ
""","""
・シャーペン(見取り図などに書き込めるもの)
・スマホ（メモ、カメラに使う）
・見取り図、メモ帳
""",nil,false,taskKey.createKey()])
        let task7 = Task(value:["家具などのの売却方法、業者を決める","""
B1主な売却方法は三つあります。

B2専門店に売却
高価買取してもらいやすいが、買取不可になることも多い。

B2リサイクルショップに売却
買取価格は低めだが、買取してもらいやすい。
直接店舗に持ち込んだ方が買取りや無料引き取りをしてもらいやすい。

B2オークション、フリマで売却
梱包、郵送、購入者との連絡など、手間がかかるが幅広いものを取引できる利点がある
トラブルが起こっても自己責任で対処する必要があり、時間に余裕を持って売却しなければならない。
""",nil,nil,false,taskKey.createKey()])
        let task8 = Task(value:["インターネット回線の解約・移転申し込み","""
基本的には新規契約をした方がキャッシュバックなどの特典がつきお得です。しかし、解約の際、違約金がかかる場合があったりプロバイダのメールアドレスが使えなくなることがあります。

回線の開通作業は予約が取りづらい場合があり、1ヶ月〜２ヶ月以上かかることもあるので引っ越し先が決まったら早めの申し込みをすることをおすすめします。
賃貸物件の場合はオーナーに許可をもらう必要もあります。

また、プロバイダ業者は回線も提供していることが多いですがそうでない場合はプロバイダと回線業者、両方の契約が必要となります。

主なプロバイダ、回線業者は以下の三つです。
Nuro光
Au光
コラボ光
""",nil,nil,false,taskKey.createKey()])
        let task9 = Task(value:["家具の売却",nil,nil,nil,false,taskKey.createKey()])
        let task10 = Task(value:["使用頻度の低い荷物を梱包",nil,nil,nil,false,taskKey.createKey()])
        let task11 = Task(value:["郵便の転送届け","郵便局か、Webサイトで手続きができます","B2Webサイトでの手続き\n・携帯電話\n\nB2郵便局での手続き\n・本人確認書類\n・旧住所が確認できるもの(運転免許証、住民票、公的機関からの郵送物)",nil,false,taskKey.createKey()])
        let task12 = Task(value:["電気の解約",nil,nil,nil,false,taskKey.createKey()])
        let task13 = Task(value:["ガスの解約",nil,nil,nil,false,taskKey.createKey()])
        let task14 = Task(value:["水道の停止",nil,nil,nil,false,taskKey.createKey()])
        let task15 = Task(value:["荷物の梱包、郵送","引っ越し業者を使わない場合はゆうパックなどの郵送サービスを利用すると安くすみます",nil,nil,false,taskKey.createKey()])
        let task16 = Task(value:["役所での手続き(転出届・健康保険の資格喪失など)","""
　　国民健康保険の場合は健康保険の資格喪失手続きが必要です
　　社会保険の場合は会社に届ければOKです
   印鑑登録をしている場合は廃止の手続きをしましょう。
""","""
 運転免許証
 印鑑
 健康保険証
 
""",nil,false,taskKey.createKey()])
        let task17 = Task(value: ["洗濯機、冷蔵庫の水抜き","B2洗濯機の水抜き手順\n\n1.洗濯機用の蛇口を閉めてしばらく洗濯機を回す\n2.給水ホースを外す\n3.脱水モードにして回す\n4.排水ホースを外す\n\n\nB2冷蔵庫の水抜き手順\n\n1.引っ越し前日までに冷蔵庫のコンセントを抜いておく\n2.水受けトレイに溜まった水を捨てる",nil,nil,false,taskKey.createKey()])
        let realm = try! Realm()
        try! realm.write{
            realm.add(taskKey)
        }
        let section1 = List<Task>()
        section1.append(task1)
        section1.append(task2)
        section1.append(task3)
        section1.append(task4)
        section1.append(task5)
        section1.append(task6)
        section1.append(task7)
        section1.append(task8)
        let section2 = List<Task>()
        section2.append(task9)
        section2.append(task10)
        section2.append(task11)
        let section3 = List<Task>()
        section3.append(task12)
        section3.append(task13)
        section3.append(task14)
        section3.append(task15)
        section3.append(task16)
        section3.append(task17)
        let s1 = Sectionobj(value:[section1,"1ヶ月前まで"])
        let s2 = Sectionobj(value:[section2,"１週間前まで"])
        let s3 = Sectionobj(value:[section3,"当日まで"])
        let s4 = Sectionobj(value: [nil,"その他"])
        let sections = List<Sectionobj>()
        sections.append(s1)
        sections.append(s2)
        sections.append(s3)
        sections.append(s4)
        self.sectionobjList =  sections
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
    func initData(){
        let section1 = Sectionobj(value: [nil,"1ヶ月前まで"])
        let section2 = Sectionobj(value: [nil,"１週間前まで"])
        let section3 = Sectionobj(value: [nil,"当日まで"])
        let section4 = Sectionobj(value: [nil,"その他"])
        let sections = List<Sectionobj>()
        sections.append(section1)
        sections.append(section2)
        sections.append(section3)
        sections.append(section4)
        self.sectionobjList = sections
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
            ["インターネット回線の開通作業",nil,nil],
            ["転入届けなどの手続き","原則転入後１４日以内に市役所で手続きをすることとなっているので早めに手続きをすませましょう。\n","・転出証明証\n・マイナンバーカード、通知カード\n・運転免許証（ない場合は本人が確認できるもの）\n・印鑑\n・国民年金手帳（厚生年金に加入していない場合)"],
            ["電気、ガス、水道の契約","電力自由化によって自分にあったプランを選べるようになりました。\nお住いのマンションの契約状況によっては選べない場合もありますが、基本的には契約先を選べるので検討することをお勧めします。",nil],
            ["日用品を購入","日常生活に必要なものは忘れずに購入するか準備しておくようにしましょう","・ティッシュペーパー\n・トイレットペーパー\n・歯ブラシ\n・洗濯用洗剤\n・タオル類\n・石鹸、シャンプー"]
        ]
        for i in datas{
            let task = Task()
            task.task = i[0]!
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
    @objc dynamic var point:String?
    @objc dynamic var requirement:String?
    @objc dynamic var memo:String? = nil
    @objc dynamic var canRemove:Bool = false
    @objc dynamic var id:Int = 0
    override static func primaryKey()->String?{
        return "id"
    }
}


