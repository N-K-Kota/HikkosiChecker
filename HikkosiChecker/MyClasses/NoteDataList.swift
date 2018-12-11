//
//  NoteDataList.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/11.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
struct NotesData{
    var title:NSAttributedString?
    var context:NSMutableAttributedString?
}
class NoteDataList{
    var dataList:Array<NotesData>
    init(){
        dataList = Array<NotesData>()
    }
}
