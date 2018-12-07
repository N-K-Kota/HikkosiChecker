//
//  SetURLViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/30.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class SetURLViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var urlTextField: UITextField!
    var addressData:Address?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
             urlTextField.delegate = self
        self.view.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if(urlTextField.text != nil && urlTextField.text != ""){
            try! realm.write{
                addressData!.url = urlTextField.text!
            }
        }
        self.dismiss(animated: true, completion: nil)
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
