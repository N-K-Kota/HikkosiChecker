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
    @objc dynamic var flag = true
    @objc dynamic var id = 0
    override static func primaryKey()->String?{
        return "id"
    }
}
class AllAddresses:Object{
    var banks = List<Address>()
    var shops = List<Address>()
    var cards = List<Address>()
    var others = List<Address>()
    func resList(_ id:Int)->List<Address>?{
        switch id{
        case 0:
            return self.banks
        case 1:
            return self.shops
           
        case 2:
            return self.cards
            
        case 3:
            return self.others
        default:
            break
        }
        return nil
    }
    func resID()->Int{
        return banks.count+shops.count+cards.count+others.count
    }
    func initData(){
        let banklist = [["楽天銀行","https://www.rakuten-bank.co.jp/"],["三菱UFJ銀行","http://direct.bk.mufg.jp/"],["三井住友銀行","https://www.smbc.co.jp/"],["新生銀行","https://www.shinseibank.com/"],["ジャパンネット銀行","https://www.japannetbank.co.jp/"],["GMOあおぞらネット","https://gmo-aozora.com/"],["イオン銀行","https://www.aeonbank.co.jp/"],["大和ネクスト銀行","https://www.bank-daiwa.co.jp/"],["オリックス銀行","https://www.orixbank.co.jp/?id=31022909999"],["じぶん銀行","https://www.jibunbank.co.jp/"],["スルガ銀行","https://www.surugabank.co.jp/surugabank/index.html"]]
        let shoplist = [["Amazon","https://www.amazon.co.jp/"],["楽天ショップ","https://www.rakuten.co.jp/"],["Yahooショップ","https://shopping.yahoo.co.jp/"]]
        let cardlist = [["楽天カード","https://www.rakuten-card.co.jp/e-navi/"],["ヤフーカード","https://card.yahoo.co.jp/"],["エポスカード","https://www.eposcard.co.jp/index.html"],["ライフカード","http://www.lifecard.co.jp/"],["アメリカンエクスプレス","https://www.americanexpress.com/japan/"]]
        var n = 0
        for i in banklist{
            let b = Address()
            b.title = i[0]
            b.url = i[1]
            b.id = n
            self.banks.append(b)
            n += 1
        }
        
        for i in shoplist{
            let s = Address()
            s.title = i[0]
            s.url = i[1]
            s.id = n
            self.shops.append(s)
            n += 1
        }
        for i in cardlist{
            let s = Address()
            s.title = i[0]
            s.url = i[1]
            s.id = n
            self.cards.append(s)
            n += 1
        }
    }
}
class AddressSection:Object{
    var section = List<Address>()
    @objc dynamic var title = ""
}
class MyAddresses:Object{
    var sections = List<AddressSection>()
    @objc dynamic var watchable = true
}
class CheckedAddresses:Object{
    var sections = List<AddressSection>()
    @objc dynamic var watchable = false
}
struct SectionsData{
    var selectSection = 0
    var lists = ["銀行","オンラインショップ","クレジットカード","その他"]
    func initData()->MyAddresses{
        let addresses = MyAddresses()
        for i in self.lists{
            let section = AddressSection()
            section.title = i
            addresses.sections.append(section)
        }
        return addresses
    }
    func initCheckedData()->CheckedAddresses{
        let addresses = CheckedAddresses()
        for i in self.lists{
            let section = AddressSection()
            section.title = i
            addresses.sections.append(section)
        }
        return addresses
    }
}
