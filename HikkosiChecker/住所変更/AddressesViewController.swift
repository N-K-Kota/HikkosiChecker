//
//  ViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/02.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
import RealmSwift
class AddressesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(section < 4){
            return mylist!.sections[section].section.count+1
         }else if(section == 4){
            return 1
         }else{
             return checkedList!.sections[section-5].section.count+1
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            if(indexPath.section == 4){
                return 30
            }else{
            return 25
            }
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 4){
           if(checkedList!.watchable){
            try! realm.write{
                checkedList!.watchable = false
            }
          }else{
            try! realm.write{
                checkedList!.watchable = true
            }
         }
          self.tableView.reloadData()
        }else if(indexPath.section < 4){
            if(indexPath.row > 0){  //セルをクリックしたらURLのページへとぶ  unchecked
                if let ur = mylist!.sections[indexPath.section].section[indexPath.row-1].url{
                    self.u = ur
                    self.webT = mylist!.sections[indexPath.section].section[indexPath.row-1].title
                    
                    print("url=\(ur)")
                    print("webT=\(mylist!.sections[indexPath.section].section[indexPath.row-1].title)")
                    performSegue(withIdentifier: "toWeb", sender: nil)
                }
            }
        }else{
            if(indexPath.row > 0){ //セルをクリックしたらURLのページへとぶ  checked
                if let ur = checkedList!.sections[indexPath.section-5].section[indexPath.row-1].url{
                    self.u = ur
                    self.webT = checkedList!.sections[indexPath.section-5].section[indexPath.row-1].title
                    print("url=\(ur)")
                    print("webT=\(checkedList!.sections[indexPath.section-5].section[indexPath.row-1].title)")
                    performSegue(withIdentifier: "toWeb", sender: nil)
                }
            }
        }
        }
    var u:String?
    var webT:String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toWeb"){
            let webpage = segue.destination as! WebPageViewController
            webpage.url = u
            webpage.title = webT
            print("inprepare:\(webT)")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "addresscell", for: indexPath) as! MyTableViewCell
        cell.btn.index = indexPath
                if(indexPath.section < 4){
                if(indexPath.row == 0){
                    cell.textLabel?.text = mylist!.sections[indexPath.section].title
                    let acView = CustomButton()
                    acView.setImage(UIImage(named: "plus"), for: .normal)
                    acView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                    acView.index = indexPath
                    acView.addTarget(self, action: #selector(accesoryTap(_:)), for: .touchUpInside)
                    cell.accessoryView = acView
                    cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
                }else{
                    cell.btn.primaryKey = mylist!.sections[indexPath.section].section[indexPath.row-1].id
                    cell.setData()
                    cell.accessoryView = nil
                    cell.accessoryType = .disclosureIndicator
                    cell.btn.setImage(UIImage(named: "spacerect"), for: .normal)
                    cell.btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
                    cell.label.text = mylist!.sections[indexPath.section].section[indexPath.row-1].title
                }
            }else if(indexPath.section > 4){
                    if(indexPath.row == 0){
                        cell.textLabel?.text = checkedList!.sections[indexPath.section-5].title
                        cell.accessoryView = nil
                        cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    }else{
                        cell.setData()
                        cell.accessoryView = nil
                        cell.btn.primaryKey = checkedList!.sections[indexPath.section-5].section[indexPath.row-1].id
                        cell.accessoryType = .disclosureIndicator
                        cell.btn.setImage(UIImage(named: "checkFrame"), for: .normal)
                        cell.btn.addTarget(self, action: #selector(clickCheckedBtn(_:)), for: .touchUpInside)
                        cell.label.text = checkedList!.sections[indexPath.section-5].section[indexPath.row-1].title
                    }
            }else{
                    cell.accessoryView = nil
                    cell.layer.cornerRadius = 10
                    cell.accessoryType = .none
                if(checkedList!.watchable){
                     cell.backgroundColor = UIColor(hex: "00bfff", alpha: 0.7)
                    cell.textLabel!.text = "チェックされたリストを非表示にする"
                }else{
                    cell.backgroundColor = UIColor(hex: "00bfff", alpha: 1)
                    cell.textLabel!.text = "チェックされたリストを表示する"
                }
            }
        return cell
    }
    @objc func clickBtn(_ sender:Any){
        let sender = sender as! CustomButton
        let id = sender.primaryKey
        let s = sender.index.section
        print("spaceSec:\(s)")
        var task:Address?
        var n = 0
        for i in mylist!.sections[s].section{//押されたセルのタスクを取得
            if(i.id == id){
                task = i
                break
            }
            n += 1
        }
        if(task == nil){
            print("error")
        }else{
        try! realm.write{                                      //チェックされたリストに追加
        checkedList!.sections[s].section.append(task!)
        }
        try! realm.write{                                    //チェックされてないリストから削除
        mylist!.sections[s].section.remove(at: n)
        }
        self.tableView.reloadData()        //Viewの更新
        }
    }
    @objc func clickCheckedBtn(_ sender:Any){
        let sender = sender as! CustomButton
        let s = sender.index.section-5
        print("clickeSec:\(s)")
        let id = sender.primaryKey
        var task:Address?
        var n = 0
        for i in checkedList!.sections[s].section{
            if(id == i.id){
                task = i
                break
            }
             n += 1
        }
        if(task == nil){
            print("error")
        }else{
        try! realm.write{
            mylist!.sections[s].section.append(task!)
        }
        try! realm.write{
            checkedList!.sections[s].section.remove(at: n)
        }
        self.tableView.reloadData()
        }
    }
    @objc func accesoryTap(_ sender:Any){
        if(tableView.isEditing == true){
          self.tableView.setEditing(false, animated: false)
          deleteBtn.tintColor = UIColor(white: 1, alpha: 1)
          deleteBtn.title = "削除"
        }
        /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "addresscollectionView") as! AddressCollectionViewController
        let sender = sender as! CustomButton
        vc.sectionId = sender.index.section
        vc.reload = {()->Void in self.tableView.reloadData()}
        self.present(vc, animated: true, completion: nil)*/
        let sender = sender as! CustomButton
        sectionData.selectSection = sender.index.section
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "collectionView") as! CollectionViewController
        vc.sectionID = sender.index.section
        vc.reload = {()->Void in self.tableView.reloadData()}
        vc.mylist = mylist
        self.present(vc, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(checkedList!.watchable == false){
            return mylist!.sections.count + 1
        }else{
            return mylist!.sections.count + checkedList!.sections.count + 1
        }
    }
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        switchdeleteBtnView()
        tableView.setEditing(!tableView.isEditing, animated: false)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(tableView.isEditing && indexPath.row != 0){
            return true
        }else{
            return false
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var data:Address
        if(indexPath.section < 4){
            data = mylist!.sections[indexPath.section].section[indexPath.row-1]
            try! realm.write{                                                    //mylistから削除
                 mylist!.sections[indexPath.section].section.remove(at: indexPath.row-1)
            }
            let list = allAddresses.resList(indexPath.section) //allAddressesのフラグを変更
            let id = list!.index(of: data)
            try! realm.write{
                list![id!].flag = true
            }
        }else{
            data = checkedList!.sections[indexPath.section-5].section[indexPath.row-1]
            try! realm.write{          //checkedListから削除
                checkedList!.sections[indexPath.section-5].section.remove(at: indexPath.row-1)
            }
            let list = allAddresses.resList(indexPath.section-5)      //allAddressesのフラグを変更
            let id = list!.index(of: data)
            try! realm.write{
                list![id!].flag = true
            }
        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    func switchdeleteBtnView(){
        if(tableView.isEditing){
            deleteBtn.tintColor = UIColor(white: 1, alpha: 1)
            deleteBtn.title = "削除"
        }else{
            deleteBtn.tintColor = UIColor(white: 1, alpha: 0.7)
            deleteBtn.title = "戻る"
        }
    }
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    var realm = try! Realm()
    var mylist:MyAddresses?
    var checkedList:CheckedAddresses?
    var sectionData = SectionsData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mylist = realm.objects(MyAddresses.self).last
        checkedList = realm.objects(CheckedAddresses.self).last
        if(mylist == nil){
            mylist = sectionData.initData()
            try! realm.write{
                realm.add(mylist!)
            }
        }
        if(checkedList == nil){
            checkedList = sectionData.initCheckedData()
            try! realm.write{
                realm.add(checkedList!)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

