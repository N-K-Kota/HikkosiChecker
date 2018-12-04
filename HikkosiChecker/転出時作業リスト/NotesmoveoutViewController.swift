//
//  NotesmoveoutViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/04.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class NotesmoveoutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UIViewControllerTransitioningDelegate{
    var task:Task?
    var points = NSMutableAttributedString()
    var requirements = NSMutableAttributedString()
    let attrClass = CustomAttrStr()
    let memoBtn = UIButton()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notescell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "03D7BE", alpha: 1).cgColor
        if(indexPath.section == 0){
            cell.textLabel?.attributedText = points
        }else if(indexPath.section == 1){
            cell.textLabel?.attributedText = requirements
        }else{
            if let m = task!.memo{
            cell.textLabel?.attributedText = NSAttributedString(string: m, attributes:attrClass.normalattr)
            }else{
                cell.textLabel?.text = ""
            }
        }
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        points = attrClass.resAttrStr(task!.point)
        requirements = attrClass.resAttrStr(task!.requirement)
        memoBtn.setImage(UIImage(named: "pen"), for: .normal)
        memoBtn.frame = CGRect(x: self.tableView.frame.width-50, y: self.view.frame.height-90, width: 30, height: 30)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        footer.backgroundColor = .clear
        return footer
    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MemoPresentationController(presentedViewController:presented,presenting:presenting)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        let titleLabel = UILabel()
        if(section == 0){
            titleLabel.attributedText = attrClass.titleForPoints
        }else if(section == 1){
            titleLabel.attributedText = attrClass.titleForRequires
        }else{
            titleLabel.attributedText = attrClass.titleForMemo
        }
        titleLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
        header.addSubview(titleLabel)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 2){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "memoView") as! MemoViewController
            vc.reload = {self.tableView.reloadData()}
            vc.task = task
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
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
