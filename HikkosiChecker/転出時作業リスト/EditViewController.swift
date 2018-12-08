//
//  EditViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/05.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var uncheckedObj:UncheckedObj?
    var checkedObj:CheckedObj?
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section>3){
                return checkedObj!.sectionobjList[section-4].taskList.count
        }else{
            return uncheckedObj!.sectionobjList[section].taskList.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
       return checkedObj!.sectionobjList.count + uncheckedObj!.sectionobjList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section < 4){
            if(uncheckedObj!.sectionobjList[section].taskList.count > 0){
            return uncheckedObj!.sectionobjList[section].title
            }
        }else{
            if(checkedObj!.sectionobjList[section-4].taskList.count > 0){
             return checkedObj!.sectionobjList[section-4].title
            }
        }
            return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height:20 ))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editcell", for: indexPath) as! MyTableViewCell
        var task = Task()
            if(indexPath.section < 4){
               task = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row]
            }else{
               task = checkedObj!.sectionobjList[indexPath.section-4].taskList[indexPath.row]
            }
            if(task.canRemove){
                cell.setData()
                cell.label.text = task.task
                cell.btn.primaryKey = task.id
                cell.btn.index = indexPath
                cell.btn.addTarget(self, action: #selector(clickedAction(_:)), for: .touchUpInside)
                cell.btn.setImage(UIImage(named:"deleteImg"), for: .normal)
            }else{
                cell.textLabel!.text = task.task
            }
        return cell
    }
    @objc func clickedAction(_ sender:Any){
        let btn = sender as! CustomButton
        let index = btn.index
       let id = btn.primaryKey
        if(index.section < 4){
            var n = 0
            for i in uncheckedObj!.sectionobjList[index.section].taskList{
                if(i.id == id){
                    try! realm.write{
                        uncheckedObj!.sectionobjList[index.section].taskList.remove(at: n)
                    }
                }
                n += 1
            }
            
            
        }else{
            var n = 0
            for i in checkedObj!.sectionobjList[index.section].taskList{
                if(i.id == id){
                    try! realm.write{
                        checkedObj!.sectionobjList[index.section].taskList.remove(at: n)
                    }
                }
                n += 1
            }
        
        }
        let cell = tableView.cellForRow(at: btn.index)
        UIView.animate(withDuration: 0.5, animations: {
            cell!.layer.opacity = 0
            }, completion: {(bool:Bool) in
                self.tableView.reloadData()
        })
    }
    let realm = try! Realm()
    var taskKey:TaskKey?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        taskKey = realm.objects(TaskKey.self).first!
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor(hex: "FDC23E", alpha: 0.7)
        textField.attributedPlaceholder = NSAttributedString(string: "+ リストに追加", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != nil && textField.text != ""){
            let task = Task()
            task.task = textField.text!
            task.canRemove = true
            try! realm.write{
                task.id = taskKey!.createKey()
                uncheckedObj!.sectionobjList.last!.taskList.append(task)
            }
            textField.text = nil
            tableView.reloadData()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
