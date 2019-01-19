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
    var btn = CustomButton()
        // Initialization code
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {  //再利用時の描画をリセット
        super.prepareForReuse()
        label.text = ""
        self.textLabel?.text = ""
        self.textLabel?.textColor = .black
        self.textLabel?.textAlignment = .left
        self.textLabel?.alpha = 1
        self.layer.cornerRadius = 0.0
        self.layer.opacity = 1
        btn.layer.opacity = 1
        label.layer.opacity = 1
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor(white: 1, alpha: 1)
        self.accessoryType = .none
        self.accessoryView = nil
        for i in self.subviews{
            if(type(of:i)==type(of:CustomButton())){
            i.removeFromSuperview()
            }
        }
        for i in self.layer.sublayers!{
            if(type(of:i) == CAGradientLayer.self){
            i.removeFromSuperlayer()
            }
        }
        btn = CustomButton()
    }
    
    func setData(){
        
        label.frame = CGRect(x: 50, y: 0, width: self.frame.width - 60, height: self.frame.height)
        btn.frame = CGRect(x: 0, y: (self.frame.height-btn.height)/2, width: btn.width, height: btn.height)
        self.addSubview(label)
        self.addSubview(btn)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
