//
//  CustomCollectionViewCell.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/27.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var label:UILabel!
    var btn:CustomButton!
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    func setup(){
        btn = CustomButton()
        label = UILabel()
        label.frame = CGRect(x: 50, y: 0, width: self.frame.width-50, height: self.frame.height)
        btn.frame = CGRect(x: 10, y: (self.frame.height-btn.height)/2, width: btn.width, height: btn.height)
        for subview in self.contentView.subviews{
            subview.removeFromSuperview()
        }
        self.contentView.addSubview(label)
        self.contentView.addSubview(btn)
    }
    
}

