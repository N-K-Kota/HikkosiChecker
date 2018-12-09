//
//  CustomButton.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/05.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    var index:IndexPath = IndexPath()
    var width:CGFloat = 44
    var height:CGFloat = 44
    var checkedFlag = false
    var primaryKey = 0
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*override func draw(_ rect: CGRect) {
        // Drawing code
    }*/
}
