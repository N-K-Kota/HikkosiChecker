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
    var reloadFunc = {()->Void in }
    @IBAction func donebtn(_ sender: UIButton) {
            if(textField.text != nil && textField.text != ""){
            let newTask = Task()
            newTask.canRemove = true
            newTask.task = textField.text!
            try! realm.write{
            uncheckedObj!.sectionobjList.last!.taskList.append(newTask)
            }
            reloadFunc()
        }
        self.dismiss(animated: true, completion:nil)
    }
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
            self.textField.delegate = self
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
