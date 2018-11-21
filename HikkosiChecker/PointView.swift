//
//  PointView.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/19.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import Foundation
import UIKit
class PointView:UIView{
    lazy var pointLabel = UILabel()
    lazy var pointTitle = UILabel()
    var ptext:String?{
        get{
        return pointLabel.text
        }
        set(ptext) {
            pointLabel.text = ptext
            self.setNeedsLayout()
            print("setted")
        }
    }
    func initLabel(){
        self.addSubview(pointLabel)
        self.addSubview(pointTitle)
        print("initlabel")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pointLabel.frame = CGRect(x: 20, y: 20, width: self.frame.width-40, height: self.frame.height)
        pointLabel.layer.borderColor = UIColor(hex: "#877168", alpha: 1).cgColor
        pointLabel.numberOfLines = 0
        pointLabel.sizeToFit()
        self.sizeToFit()
        pointTitle.text = "☆ポイント"
        pointTitle.frame = CGRect(x:20, y: 0, width: 100, height: 20)
        self.setNeedsLayout()
    }
    required override init(frame: CGRect) {
        super.init(frame:frame)
        initLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        initLabel()
    }
}
