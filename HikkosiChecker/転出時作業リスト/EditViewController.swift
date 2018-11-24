//
//  EditViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/05.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate {
    
    @objc func addButton(_ sender: UIButton) {
        let nvc = self.storyboard?.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
        nvc.modalPresentationStyle = .custom
        nvc.transitioningDelegate = self
        nvc.reloadFunc = {
            self.tableView.reloadData()
        }
        self.present(nvc,animated: true,completion: nil)
    }
    
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteMoveoutView") as! DeleteMoveoutListViewController
        vc.modalPresentationStyle = .popover
        vc.reloadFunc = {
            self.tableView.reloadData()
        }
        self.present(vc,animated: true,completion: nil)
    }
    @IBOutlet weak var toolBar: UIToolbar!
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationViewController(presentedViewController:presented,presenting:presenting)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section>4){
            if(checkedObj!.watchable){  //チェックしたリストを表示
                return checkedObj!.sectionobjList[section-5].taskList.count
            }else{
                
            }
        }else if(section<4){
            return uncheckedObj!.sectionobjList[section].taskList.count
        }else{
            return 1
        }
       return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            if(checkedObj!.watchable){
                return checkedObj!.sectionobjList.count + uncheckedObj!.sectionobjList.count + 1
            }else{
                return uncheckedObj!.sectionobjList.count + 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section < 4){
            if(uncheckedObj!.sectionobjList[section].taskList.count > 0){
            return uncheckedObj!.sectionobjList[section].title
            }
        }else if(section > 4){
            if(checkedObj!.sectionobjList[section-5].taskList.count > 0){
             return checkedObj!.sectionobjList[section-5].title
            }
        }
            return ""
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 4){
            try! realm.write{
                checkedObj!.watchable = !checkedObj!.watchable
            }
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height:20 ))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editcell", for: indexPath) as! MyTableViewCell
        if(indexPath.section < 4){
            cell.label.text = uncheckedObj!.sectionobjList[indexPath.section].taskList[indexPath.row].task
            let btn = CustomButton()
            btn.setImage(UIImage(named: "spacerect"), for: .normal)
            btn.index = indexPath
            btn.width = 30.0
            btn.height = 30.0
            btn.frame = CGRect(x: 0, y: (cell.frame.height - btn.height)/2, width: btn.width, height: btn.height)
            btn.addTarget(self, action: #selector(clickedAction(_:)), for: .touchUpInside)
            cell.addSubview(btn)
        }else if(indexPath.section > 4){
            cell.label.text = checkedObj!.sectionobjList[indexPath.section-5].taskList[indexPath.row].task
            let btn = CustomButton()
            btn.setImage(UIImage(named: "spacerect"), for: .normal)
            btn.index = indexPath
            btn.width = 30.0
            btn.height = 30.0
            btn.frame = CGRect(x: 0, y: (cell.frame.height - btn.height)/2, width: btn.width, height: btn.height)
            btn.addTarget(self, action: #selector(clickedAction(_:)), for: .touchUpInside)
            cell.addSubview(btn)
        }else{
            if(checkedObj!.watchable){
                cell.textLabel!.text = "非表示にする"
            }else{
                cell.textLabel!.text = "表示する"
            }
            cell.layer.cornerRadius = 15
            cell.accessoryType = .none
            cell.backgroundColor = UIColor(red: 251/255, green: 232/255, blue: 153/255, alpha: 1)
        }
        return cell
    }
    @objc func clickedAction(_ sender:Any){
        let btn = sender as! CustomButton
        if(btn.checkedFlag){
            btn.setImage(UIImage(named: "spacerect"), for: .normal)
            btn.checkedFlag = false
        }else{
            btn.setImage(UIImage(named: "checkFrame"), for: .normal)
            btn.checkedFlag = true
        }
    }
    var checkedIndexes = Array<IndexPath>()
    var addedList:String?
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         toolBar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-80, width: UIScreen.main.bounds.width, height: 80)
        let addbtn = UIButton()
        addbtn.frame = CGRect(x: (UIScreen.main.bounds.width-180)/2, y: (UIScreen.main.bounds.height-120), width: 180, height: 40)
        addbtn.layer.cornerRadius = 15
        addbtn.layer.shadowColor = UIColor.black.cgColor
        addbtn.layer.shadowOpacity = 0.4
        addbtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        addbtn.layer.shadowRadius = 12
        addbtn.backgroundColor = UIColor(red: 147/255, green: 207/255, blue: 245/255, alpha: 1)
        addbtn.setTitle("リストに追加", for: .normal)
        addbtn.addTarget(self, action: #selector(addButton(_:)), for: .touchUpInside)
        self.view.addSubview(addbtn)
        // Do any additional setup after loading the view.
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
