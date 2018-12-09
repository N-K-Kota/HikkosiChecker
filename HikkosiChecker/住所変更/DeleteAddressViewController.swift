//
//  DeleteAddressViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/07.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class DeleteAddressViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let realm = try! Realm()
    var myList:AddressView?
    var checkedList:AddressView?
    var dataList = AddressView()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.sections[section].section.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath) as! MyTableViewCell
        cell.setData()
        //cell.btn.primaryKey = dataList[indexPath.section].section[indexPath.row].id
        cell.btn.index = indexPath
        cell.btn.addTarget(self, action: #selector(deleteFunc(_:)), for: .touchUpInside)
        cell.label.text = dataList.sections[indexPath.section].section[indexPath.row].title
        cell.label.textColor = UIColor(white: 0.1, alpha: 1)
        cell.btn.setImage(UIImage(named: "deleteImg"), for: .normal)
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20)
        let label = UILabel()
        label.text = dataList.sections[section].title
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.frame = CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height)
        header.addSubview(label)
        header.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        return header
    }*/
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataList.sections[section].title
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20)
        footer.backgroundColor = .clear
        return footer
    }
    @objc func deleteFunc(_ sender:Any){
        let btn = sender as! CustomButton
        let index = btn.index
        try! realm.write{
          dataList.sections[index.section].section[index.row].flag = true
        }
        dataList.sections[index.section].section.remove(at: index.row)
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.cellForRow(at: index)?.layer.opacity = 0
        }, completion: {(bool:Bool)-> Void in
            self.tableView.reloadData()
        })
    }

    @IBOutlet weak var tableView: UITableView!
    @IBAction func returnBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(myList != nil && checkedList != nil){
            dataList.initData()
        for i in 0..<4{
            for v in myList!.sections[i].section{
                dataList.sections[i].section.append(v)
            }
            for v in checkedList!.sections[i].section{
                dataList.sections[i].section.append(v)
            }
        }
        }
        
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
