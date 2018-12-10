//
//  MemoViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/04.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class MemoViewController: UIViewController,UITextViewDelegate {
    var task:Task?
    var dataList:NoteDataList?
    var reload = {()->Void in}
    let realm = try! Realm()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         textView.delegate = self
        // Do any additional setup after loading the view.
        textView.textAlignment = .left
        textView.returnKeyType = .done
        textView.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 10))
        textView.textColor = UIColor(white: 0.5, alpha: 1)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(white: 0.3, alpha: 1).cgColor
        if let memo = task!.memo{
        textView.text = memo
        }else{
            textView.text = ""
        }
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width:1, height:1)
        shadow.shadowColor = UIColor(hex: "073D6A", alpha: 1)
        titleLabel.attributedText = NSAttributedString(string: "☆メモ", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex: "0A60AA", alpha: 1),NSAttributedString.Key.shadow:shadow])
        closeBtn.layer.borderColor = UIColor(white: 0.8, alpha: 0.5).cgColor
        closeBtn.layer.borderWidth = 1
        closeBtn.layer.cornerRadius = 10
        closeBtn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 40)
        closeBtn.frame = CGRect(x: 10+titleLabel.frame.width+60, y: 10, width: 50, height: 50)
        textView.frame = CGRect(x: 10, y: 70, width: self.view.frame.width-20, height:self.view.frame.height-70-self.view.safeAreaInsets.bottom)
    }
    @IBAction func endBtn(_ sender: UIButton) {
        textView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.dismiss(animated: true, completion: nil)
        if(textView.text != nil){
        try! realm.write{
            task!.memo = textView.text
        }
            if let list = dataList{
             list.dataList[list.dataList.count-1].context = CustomAttrStr().resAttrStr(textView.text)
            }else{
                print("found dataList nil")
            }
        }
        reload()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
