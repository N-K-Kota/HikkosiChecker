//
//  AppDelegate.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func initData()->List<Sectionobj>{
        let task1 = Task()
        task1.task = "持ち物の分類"
        task1.point = "引っ越しは不用品を処分する絶好の機会です。一年以上使っていないものは基本的に売るか捨てるかすることをお勧めします。"
        
        let task2 = Task()
        task2.task = "粗大ゴミの申し込み"
        task2.point = "市区町村によってゴミの出し方、処分費用は変わるので確認しましょう。\n粗大ゴミは月一回しか出せない市区町村も多いので早めに出せる日にちを確認することが必要です。\nクリーンセンターなどに持ち込みをすると費用が抑えられることもありますが、その場合も予約が必要です。"
        let task3 = Task()
        task3.task = "ゴミ出し曜日の確認"
        let task4 = Task(value:["住居の解約届","","",nil,false])
        let task5 = Task(value:["引っ越し業者を決める","業者によって料金が大きく変わることがあるので複数の業者を比較しましょう。\n一括見積もりサイトを利用すると便利です。","",nil,false])
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
""",nil,false])
        let task7 = Task(value:["家具などのの売却方法、業者を決める","""
主な売却方法は三つあります。
専門店に売却
高価買取してもらいやすいが、買取不可になることも多い。
リサイクルショップに売却
買取価格は低めだが、買取してもらいやすい。
オークション、フリマで売却
梱包、郵送、購入者との連絡など、手間がかかるが幅広く売却できる利点がある。
トラブルが起こっても自己責任で対処する必要があり、時間に余裕を持って売却しなければならない。
""","",nil,false])
        let task8 = Task(value:["インターネット回線の解約・移転申し込み","""
インターネット回線の解約・移転申し込み
インターネットの新規契約をするとキャッシュバックなど特典がつくことがありお得ですが、解約の際、違約金がかかる場合があったりプロバイダのメールアドレスが使えなくなることがあります。プロバイダが回線も提供していることが多いですがそうでない場合はプロバイダと回線業者、両方の契約が必要となります。
主なプロバイダ、回線業者は以下の三つです。
Nuro光
Au光
コラボ光
""","",nil,false])
        let task9 = Task(value:["家具の売却","","",nil,false])
        let task10 = Task(value:["使用頻度の低い荷物を梱包","","",nil,false])
        let task11 = Task(value:["郵便の転送届け","","",nil,false])
        let task12 = Task(value:["電気の解約","","",nil,false])
        let task13 = Task(value:["ガスの解約","","",nil,false])
        let task14 = Task(value:["水道の停止","","",nil,false])
        let task15 = Task(value:["荷物の梱包、郵送","","",nil,false])
        let task16 = Task(value:["役所での手続き(転出届・健康保険の資格喪失など)","""
　　国民健康保険の場合は健康保険の資格喪失手続きが必要です
　　社会保険の場合は会社に届ければOKです
""","""
 運転免許証
 印鑑
 健康保険証
 
""",nil,false])
        
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
        let s1 = Sectionobj(value:[section1,"1ヶ月前まで"])
        let s2 = Sectionobj(value:[section2,"１週間前まで"])
        let s3 = Sectionobj(value:[section3,"当日まで"])
        let s4 = Sectionobj(value: [nil,"その他"])
        let sections = List<Sectionobj>()
        sections.append(s1)
        sections.append(s2)
        sections.append(s3)
        sections.append(s4)
        return sections
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var config = Realm.Configuration(schemaVersion: 2, migrationBlock: {
            migration,oldSchemaVersion in
            if(oldSchemaVersion<2){
            }
        })
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = try! Realm()
        if(UserDefaults.standard.object(forKey: "Flag") != nil){
            checkedObj = realm.objects(CheckedObj.self).first!
            uncheckedObj = realm.objects(UncheckedObj.self).first!
        }else{
            print("noflag")
            UserDefaults.standard.set(true, forKey: "Flag")
            uncheckedObj = UncheckedObj(value: [initData()])
            let section1 = Sectionobj(value: [nil,"1ヶ月前まで"])
            let section2 = Sectionobj(value: [nil,"１週間前まで"])
            let section3 = Sectionobj(value: [nil,"当日まで"])
            let section4 = Sectionobj(value: [nil,"その他"])
            let sections = List<Sectionobj>()
            sections.append(section1)
            sections.append(section2)
            sections.append(section3)
            sections.append(section4)
            checkedObj = CheckedObj(value: [sections])
            let mySection = Sectionobj()
            let myTask = Task()
            try! realm.write{
                realm.add(myTask)
                realm.add(mySection)
                realm.add(checkedObj!)
                realm.add(uncheckedObj!)
            }
        }
       
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

