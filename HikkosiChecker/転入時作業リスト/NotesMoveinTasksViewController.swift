//
//  NotesMoveinTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/01.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class NotesMoveinTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate {
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveinNotesCell", for: indexPath)
        //cell.textLabel?.attributedText = NSAttributedString(string: "")
        cell.textLabel?.numberOfLines = 0
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "03D7BE", alpha: 1).cgColor
        cell.textLabel?.attributedText = dataList.dataList[indexPath.section].context
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x:0 , y:0 , width: tableView.frame.width, height: 30)
        view.backgroundColor = .clear
        let label = UILabel()
        label.attributedText = dataList.dataList[section].title
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(label)
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.dataList.count
    }
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        footer.backgroundColor = .clear
        return footer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(dataList.dataList.count-1 == indexPath.section){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "memoView") as! MemoViewController
            vc.reload = {self.tableView.reloadData()}
            vc.task = task
            vc.dataList = dataList
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    var task:Task?
    var dataList = NoteDataList()
    let attrClass = CustomAttrStr()
    let memoBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = task!.point{
            var notes = NotesData()
            notes.title = attrClass.titleForPoints
            notes.context = attrClass.resAttrStr(p)
            dataList.dataList.append(notes)
        }
        if let r = task!.requirement{
            var notes = NotesData()
            notes.title = attrClass.titleForRequires
            notes.context = attrClass.resAttrStr(r)
            dataList.dataList.append(notes)
        }
        if let m = task!.memo{
            var notes = NotesData()
            notes.title = attrClass.titleForMemo
            notes.context = attrClass.resAttrStr(m)
            dataList.dataList.append(notes)
        }else{
            var notes = NotesData()
            notes.title = attrClass.titleForMemo
            notes.context = NSMutableAttributedString()
            dataList.dataList.append(notes)
        }
        memoBtn.setImage(UIImage(named:"pen"), for: .normal)
        memoBtn.addTarget(self, action: #selector(popMemo(_:)), for: .touchUpInside)
        self.view.addSubview(memoBtn)
        // Do any additional setup after loading the view.
    }
    @objc func popMemo(_ sender:Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "memoView") as! MemoViewController
        vc.reload = {self.tableView.reloadData()}
        vc.task = task
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        memoBtn.frame = CGRect(x: self.view.frame.width-50, y: self.view.frame.height-90, width: 30, height: 30)
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MemoPresentationController(presentedViewController:presented,presenting:presenting)
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
