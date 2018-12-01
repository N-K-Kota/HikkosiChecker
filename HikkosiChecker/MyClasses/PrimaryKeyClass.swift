//
//  File.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/30.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import RealmSwift

class MyKey:Object{
    @objc dynamic var id = -1
    func createKey()->Int{
        id += 1
        return id
    }
}
class TaskKey:Object{
    @objc dynamic var id = -1
    func createKey()->Int{
        id += 1
        return id
    }
}
