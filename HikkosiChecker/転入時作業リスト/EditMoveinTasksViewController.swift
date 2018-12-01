//
//  EditMoveinTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/01.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class EditMoveinTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var reload = {()->Void in}
    @IBOutlet weak var tableView: UITableView!
    @IBAction func returnFunc(_ sender: UIBarButtonItem) {
        reload()
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textField: UITextField!
    @IBAction func delteBtnFunc(_ sender: UIBarButtonItem) {
        for i in checkedIDList{
            var n = 0
            for z in moveinList!.taskList{ //チェックしてないリストから探す
                if(z.id == i){
                    try! realm.write{
                        moveinList!.taskList.remove(at:n)
                    }
                    break
                }
                n += 1
            }
            n = 0
            for z in didmoveinList!.taskList{ //チェック済みリストから探す
                if(z.id == i){
                    try! realm.write{
                        didmoveinList!.taskList.remove(at:n)
                    }
                    break
                }
                n += 1
            }
        }
        checkedIDList = Array<Int>()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return moveinList!.taskList.count
        }else{
            return didmoveinList!.taskList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editmoveinCell",for:indexPath) as! MyTableViewCell
        if(indexPath.section == 0){
            if(moveinList!.taskList[indexPath.row].canRemove){//
                cell.setData()
                cell.label.text = moveinList!.taskList[indexPath.row].task
                cell.btn.addTarget(self, action: #selector(clickFunc(_:)), for: .touchDown)
                if(cell.btn.checkedFlag){
                }else{
                    cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                }
                cell.btn.primaryKey = moveinList!.taskList[indexPath.row].id
            }else{
                cell.textLabel!.text = moveinList!.taskList[indexPath.row].task
            }
            
        }else{
            if(didmoveinList!.taskList[indexPath.row].canRemove){//
                cell.setData()
                cell.label.text = didmoveinList!.taskList[indexPath.row].task
                cell.btn.addTarget(self, action: #selector(clickFunc(_:)), for: .touchDown)
                if(cell.btn.checkedFlag){
                }else{
                    cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                }
                cell.btn.primaryKey = didmoveinList!.taskList[indexPath.row].id
            }else{
                cell.textLabel!.text = didmoveinList!.taskList[indexPath.row].task
            }
        }
        return cell
    }
    @objc func clickFunc(_ sender:Any){
        let btn = sender as! CustomButton
        if(btn.checkedFlag){
            btn.checkedFlag = false
            let x = checkedIDList.index(of:btn.primaryKey)
            checkedIDList.remove(at: x!)
            btn.setImage(UIImage(named: "spacerect"), for: .normal)
        }else{
            btn.checkedFlag = true
            checkedIDList.append(btn.primaryKey)
            btn.setImage(UIImage(named: "checkFrame"), for: .normal)
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    var checkedIDList = Array<Int>()
    var moveinList:MoveinList?
    var didmoveinList:DidMoveinList?
    let realm = try! Realm()
    var taskKey:TaskKey?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor(hex: "FDC23E", alpha: 0.7)
        textField.attributedPlaceholder = NSAttributedString(string: "+ リストに追加", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        taskKey = realm.objects(TaskKey.self).first!
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //完了したらキーボードを閉じる奴
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) { //リストに追加
        if(textField.text != nil && textField.text != ""){
            let task = Task()
            task.task = textField.text!
            task.canRemove = true
            try! realm.write{
                task.id = taskKey!.createKey()
                moveinList!.taskList.append(task)
            }
            self.tableView.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
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
