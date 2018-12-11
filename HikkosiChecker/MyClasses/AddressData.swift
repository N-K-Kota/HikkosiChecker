//
//  AddressData.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit


struct AddressBufer{           //住所変更ディレクトリのCollectionViewControllerでチェックされたリストを保存するのに使う
    var buffer = Array<Bool>()
    var checkStart = false
    mutating func  setBuffer(_ datacount:Int){
        buffer = Array<Bool>()
        for _ in 0..<datacount{
            buffer.append(false)
        }
    }
    mutating func addbuf(_ row:Int){
        if(!checkStart){
            checkStart = true
        }
        buffer[row] = true
    }
    mutating func subbuf(_ row:Int){
        buffer[row] = false
        if let _ = buffer.index(of:true){
        }else{
            checkStart = false
        }
    }
}
