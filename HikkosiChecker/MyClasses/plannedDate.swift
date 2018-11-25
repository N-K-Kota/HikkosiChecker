//
//  plannedDate.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/23.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit

struct PlannedDate{
    var date:Date?
    static let key = "DateKey"
    mutating func readDate(){
        self.date = UserDefaults.standard.object(forKey: PlannedDate.key) as? Date
    }
    func setDate(){
        if(date != nil){
           UserDefaults.standard.set(self.date, forKey: PlannedDate.key)
        }
    }
    func toString()->String{
        if(date != nil){
            let formatter = DateFormatter()
            formatter.dateFormat = "MM月dd日"
            return formatter.string(from: date!)
        }else{
            return "未定"
        }
    }
    func leftDates()->String{
        if let d = date{
            let interval = d.timeIntervalSinceNow
            if(interval>0){
              let leftdate = Double(interval)/24/60/60
              return "\(floor(leftdate))日"
            }else{
                return "終了"
            }
        }else{
            return "未定"
        }
    }
}
