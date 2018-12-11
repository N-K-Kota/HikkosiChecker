//
//  HexColorClass.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/19.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{            //ウェブサイトからコピペしたコード
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
