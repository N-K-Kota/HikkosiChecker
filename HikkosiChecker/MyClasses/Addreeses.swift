//
//  Addreeses.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/26.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Address:Object{
    @objc dynamic var title = ""
    @objc dynamic var url:String?
    @objc dynamic var flag = true  //trueなら追加リストへ、falseなら住所変更リストへ表示される
    @objc dynamic var checked = false //チェックされたらtrue
    @objc dynamic var id = 0
    override static func primaryKey()->String?{
        return "id"
    }
}
class AllAddresses:Object{
    var sections = List<AddressSection>()
    func resAll()->Int{
        var t = 0
        for i in sections{
            t += i.section.count
        }
        return t
    }
    func diplayDatas(myList:AddressView,checkedList:AddressView){
        for v in 0..<4{
            for i in sections[v].section{
             if(!i.flag){    //住所変更リストに表示するデータ
                if(i.checked){  //チェックされているデータ
                    checkedList.sections[v].section.append(i)
                }else{         //チェックされていないデータ
                     myList.sections[v].section.append(i)
                }
             }
            }
        }
    }
   
    func initData(_ keyobj:MyKey){
        let titles = ["銀行","オンラインショップ","クレジットカード","その他"]
        for i in 0..<4{
            let addSec = AddressSection()
            addSec.title = titles[i]
            self.sections.append(addSec)
        }
        let banklist = [["楽天銀行","https://www.rakuten-bank.co.jp/"],["三菱UFJ銀行","http://direct.bk.mufg.jp/"],["三井住友銀行","https://www.smbc.co.jp/"],["新生銀行","https://www.shinseibank.com/"],["ジャパンネット銀行","https://www.japannetbank.co.jp/"],["GMOあおぞらネット","https://gmo-aozora.com/"],["イオン銀行","https://www.aeonbank.co.jp/"],["大和ネクスト銀行","https://www.bank-daiwa.co.jp/"],["オリックス銀行","https://www.orixbank.co.jp/?id=31022909999"],["じぶん銀行","https://www.jibunbank.co.jp/"],["スルガ銀行","https://www.surugabank.co.jp/surugabank/index.html"]]
        let shoplist = [["Amazon","https://www.amazon.co.jp/"],["楽天ショップ","https://www.rakuten.co.jp/"],["Yahooショップ","https://shopping.yahoo.co.jp/"]]
        let cardlist = [["楽天カード","https://www.rakuten-card.co.jp/e-navi/"],["ヤフーカード","https://card.yahoo.co.jp/"],["エポスカード","https://www.eposcard.co.jp/index.html"],["ライフカード","http://www.lifecard.co.jp/"],["アメリカンエクスプレス","https://www.americanexpress.com/japan/"],["オリコカード","https://www.orico.co.jp/"],["イオンカード","http://www.aeon.co.jp/creditcard/"]]
        for i in banklist{
            let b = Address()
            b.title = i[0]
            b.url = i[1]
            b.id = keyobj.createKey()
            self.sections[0].section.append(b)
        }
        
        for i in shoplist{
            let s = Address()
            s.title = i[0]
            s.url = i[1]
            s.id = keyobj.createKey()
           self.sections[1].section.append(s)
        }
        for i in cardlist{
            let s = Address()
            s.title = i[0]
            s.url = i[1]
            s.id = keyobj.createKey()
            self.sections[2].section.append(s)
        }
    }
}
class AddressView:Object{
    var sections = List<AddressSection>()
    var watchable = false
    func initData(){
        sections = List<AddressSection>()
        var sectiontitles = ["銀行","オンラインショップ","クレジットカード","その他"]
        for i in 0..<4{
            let sec = AddressSection()
            sec.title = sectiontitles[i]
            sections.append(sec)
        }
    }
    func taskCount()->Int{
        var n = 0
        for i in sections{
            n += i.section.count
        }
        return n
    }
}
class AddressSection:Object{
    var section = List<Address>()
    @objc dynamic var title = ""
}
