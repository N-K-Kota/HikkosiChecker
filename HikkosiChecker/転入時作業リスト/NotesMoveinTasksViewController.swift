//
//  NotesMoveinTasksViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/01.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class NotesMoveinTasksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
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
        if(indexPath.section == 0){
            cell.textLabel?.attributedText = points
        }else{
            cell.textLabel?.attributedText = requirements
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x:0 , y:0 , width: tableView.frame.width, height: 30)
        let label = UILabel()
        if(section == 0){
            label.attributedText = attrClass.titleForPoints
        }else{
            label.attributedText = attrClass.titleForRequires
        }
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(label)
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        footer.backgroundColor = .clear
        return footer
    }
    var task:Task?
    var points = NSMutableAttributedString()
    var requirements = NSMutableAttributedString()
    let attrClass = CustomAttrStr()
    override func viewDidLoad() {
        super.viewDidLoad()
        points = attrClass.resAttrStr(task!.point)
        requirements = attrClass.resAttrStr(task!.requirement)
        print(points)
        print(requirements)
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
