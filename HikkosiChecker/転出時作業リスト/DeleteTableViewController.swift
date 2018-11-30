//
//  DeleteTableViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/24.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class DeleteTableViewController: UITableViewController {
    var reloadFunc = {()->Void in}
    var checkedList = Array<Task>()
    var deletableList = Array<DeletableList>()
    let realm = try! Realm()
    let returnBtn = UIButton()
    let deleteBtn = UIButton()
    var scrolledV:CGFloat = 0
    @objc func checkAction(_ sender:Any){   //チェックボックスをクリックされた時の処理
        let sender = sender as! CustomButton  //DeletableListのIndexと対応するボタン
        if(sender.checkedFlag){                                        //チェック済みの場合
            sender.setImage(UIImage(named: "spacerect"), for: .normal)
            sender.checkedFlag = false
            let ind = checkedList.index(of:deletableList[sender.index.row].task) //チェックされたタスクからIndexを求める
            checkedList.remove(at:ind!)
        }else{                                                       //チェックされていなかった場合
            sender.setImage(UIImage(named: "checkFrame"), for: .normal)
            sender.checkedFlag = true
            checkedList.append(deletableList[sender.index.row].task)
        }
    }
   @objc func returnFunc(_ sender: UIBarButtonItem) {
        reloadFunc()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func deleteFunc(_ sender: UIButton) {
        for v in checkedList{
            var n = 0
            for i in deletableList{
                if(i.task == v){
                    if(i.flag){
                        let ip = uncheckedObj!.sectionobjList.last!.taskList.index(of: i.task)
                        try! realm.write{
                            uncheckedObj!.sectionobjList.last!.taskList.remove(at: ip!)
                        }
                    }else{
                        let ip = checkedObj!.sectionobjList.last!.taskList.index(of: i.task)
                        try! realm.write{
                            checkedObj!.sectionobjList.last!.taskList.remove(at:ip!)
                        }
                    }
                    deletableList.remove(at: n)
                    break         //nを増やさないで次のループへ飛ぶ
                }
                n += 1
            }
        }
        checkedList = Array<Task>()   //チェックリストを初期化する
        tableView.reloadData()
        reloadFunc()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var r = 0
            for v in uncheckedObj!.sectionobjList.last!.taskList{
                if(v.canRemove){
                    deletableList.append(DeletableList(v,IndexPath(row: r, section: 3),true))
                }
                r += 1
            }
        r = 0
        for i in checkedObj!.sectionobjList.last!.taskList{
            if(i.canRemove){
                deletableList.append(DeletableList(i,IndexPath(row: r, section: 3),true))
            }
            r += 1
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        returnBtn.addTarget(self, action:#selector(returnFunc(_:)) , for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteFunc(_:)), for: .touchUpInside)
        deleteBtn.setTitle("削除", for: .normal)
        deleteBtn.backgroundColor = UIColor(hex: "78BBE6", alpha: 1)
        self.view.addSubview(deleteBtn)
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deletableList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MyTableViewCell
        cell.setData()
        cell.label.text = deletableList[indexPath.row].task.task
        cell.btn.index = indexPath
        cell.btn.setImage(UIImage(named:"spacerect"), for: .normal)
        cell.btn.addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
        return cell
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         deleteBtn.frame = CGRect(x: self.view.center.x-50, y: self.view.frame.height-(80+self.view.safeAreaInsets.bottom)+scrolledV, width: 100, height: 60)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrolledV = scrollView.contentOffset.y
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
