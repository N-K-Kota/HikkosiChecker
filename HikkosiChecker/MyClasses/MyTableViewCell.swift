//
//  MyTableViewCell.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/05.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    var indexPath:IndexPath?
    var label = UILabel()
    var width = 30
    var height = 30
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.frame = CGRect(x: 40, y: 0, width: self.frame.width - 60, height: self.frame.height)
        self.addSubview(label)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        self.textLabel?.text = ""
        self.layer.cornerRadius = 0.0
        self.backgroundColor = UIColor(white: 1, alpha: 1)
        for i in self.subviews{
            if(type(of:i)==type(of:CustomButton())){
            i.removeFromSuperview()
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
