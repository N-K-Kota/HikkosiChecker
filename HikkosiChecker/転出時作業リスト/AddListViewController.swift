//
//  AddListViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/13.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class AddListViewController: UIViewController,UITextFieldDelegate {
    let realm = try! Realm()
    var taskKey:TaskKey?
    var reloadFunc = {()->Void in }  //編集ページからクロージャをもらってリロードする
    @IBAction func donebtn(_ sender: UIButton) {  //完了ボタンを押された時の処理
            if(textField.text != nil && textField.text != ""){ //テキストが空の時はリストへ追加されないように
            let newTask = Task()
                newTask.canRemove = true
                newTask.task = textField.text!
                newTask.id = taskKey!.createKey()
            try! realm.write{
            uncheckedObj!.sectionobjList.last!.taskList.append(newTask)  //セクションの最後は必ず追加されたリストが入る
            }
            reloadFunc()
        }
        self.dismiss(animated: true, completion:nil)
    }
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
            self.textField.delegate = self
            taskKey = realm.objects(TaskKey.self).first!
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigatio
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
