//
//  AttributedString.swift
//  
//
//  Created by Kota Nakamura on 2018/12/01.
//

import Foundation
import UIKit

struct CustomAttrStr{
    let customattr1:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 4))]
    let customattr2:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))]
    let normalattr:[NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor:UIColor(white: 0.2, alpha: 1)]
    let titleForPoints:NSAttributedString
    let titleForRequires:NSAttributedString
    let titleForMemo:NSAttributedString
    init(){
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width:1, height:1)
        shadow.shadowColor = UIColor(hex: "073D6A", alpha: 1)
        let attr:[NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor:UIColor(hex: "0A60AA", alpha: 1),NSAttributedString.Key.shadow:shadow]
        titleForPoints = NSAttributedString(string: "☆チェックポイント", attributes: attr)
        titleForRequires = NSAttributedString(string: "☆必要なもの", attributes: attr)
        titleForMemo = NSAttributedString(string: "☆メモ", attributes:attr)
    }
    func resAttrStr(_ str:String)->NSMutableAttributedString{
        let attr = str.components(separatedBy:"\n")
        let strings = NSMutableAttributedString()
        for i in attr{
            if(String(i.prefix(2)) == "B1"){ //装飾文字の作成
                strings.append(NSAttributedString(string:String(i.suffix(i.count-2)), attributes:customattr1))
                strings.append(NSAttributedString(string: "\n"))
            }else if(String(i.prefix(2)) == "B2"){
                strings.append(NSAttributedString(string: String(i.suffix(i.count-2)), attributes: customattr2))
            }else{         //普通の文字
                strings.append(NSAttributedString(string: i,attributes:normalattr))
            }
            strings.append(NSAttributedString(string: "\n"))
        }
        return strings
    }
}
