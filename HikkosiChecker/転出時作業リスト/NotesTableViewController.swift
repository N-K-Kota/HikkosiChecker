//
//  NotesTableViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/20.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    var task:Task?
    var points = NSMutableAttributedString()   //チェックポイント欄の文章が入る
    var requirements = NSMutableAttributedString()  //必要なもの欄の文章が入る
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let attrB2:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 4))]  //太字,中くらいの大きさの文字
        let attrB1:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))]  //太字、一番大きな文字
        let attr = [NSAttributedString.Key.foregroundColor:UIColor(white: 0.2, alpha: 1)] //普通の文字
        let pointStr = task!.point.components(separatedBy: "\n") //改行ごとに分けて装飾する
        for i in pointStr{   //チェックポイント欄の文章を装飾する
            if(String(i.prefix(2)) == "B1"){ //装飾文字の作成
                points.append(NSAttributedString(string:String(i.suffix(i.count-2)), attributes:attrB1))
                points.append(NSAttributedString(string: "\n"))
            }else if(String(i.prefix(2)) == "B2"){
                points.append(NSAttributedString(string: String(i.suffix(i.count-2)), attributes: attrB2))
            }else{         //普通の文字
                points.append(NSAttributedString(string: i,attributes:attr))
            }
             points.append(NSAttributedString(string: "\n"))
        }
        let requireStr = task!.requirement.components(separatedBy: "\n")
        for i in requireStr{         //必要なもの欄の文章を装飾する
            if(String(i.prefix(2)) == "B1"){ //装飾文字の作成
                requirements.append(NSAttributedString(string:String(i.suffix(i.count-2)), attributes:attrB1))
            }else if(String(i.prefix(2)) == "B2"){
                requirements.append(NSAttributedString(string: String(i.suffix(i.count-2)), attributes: attrB2))
            }else{         //普通の文字
                requirements.append(NSAttributedString(string: i))
            }
            requirements.append(NSAttributedString(string: "\n"))
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        footer.backgroundColor = .clear
        return footer
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        headerView.backgroundColor = .clear
        let titleLabel = UILabel()
        if(section == 0){
            let shadow = NSShadow()
            shadow.shadowOffset = CGSize(width:1, height:1)
            shadow.shadowBlurRadius = 4
            shadow.shadowColor = UIColor(hex: "073D6A", alpha: 1)
            let point = NSAttributedString(string: "☆チェックポイント", attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex: "0A60AA", alpha: 1),NSAttributedString.Key.shadow:shadow])
            titleLabel.attributedText = point
        }else if(section == 1){
            let shadow = NSShadow()
            shadow.shadowOffset = CGSize(width:1, height:1)
            shadow.shadowColor = UIColor(hex: "073D6A", alpha: 1)
            let requirement = NSAttributedString(string: "☆必要なもの", attributes:[NSAttributedString.Key.foregroundColor:UIColor(hex: "0A60AA", alpha: 1),NSAttributedString.Key.shadow:shadow])
            titleLabel.attributedText = requirement
        }
        titleLabel.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        headerView.addSubview(titleLabel)
        //titleLabel.textColor = .blue
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notescell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "03D7BE", alpha: 1).cgColor
        if(indexPath.section == 0){
            cell.textLabel?.attributedText = points
        }else if(indexPath.section == 1){
            cell.textLabel?.attributedText = requirements
        }
        // Configure the cell...

        return cell
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
