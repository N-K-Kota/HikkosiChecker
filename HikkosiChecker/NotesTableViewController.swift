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
    override func viewDidLoad() {
        super.viewDidLoad()

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
        var titleLabel = UILabel()
        if(section == 0){
            titleLabel.text = "☆ポイント"
        }else if(section == 1){
            titleLabel.text = "必要なもの"
        }
        titleLabel.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor(hex: "86A7AF", alpha: 1)
        //titleLabel.textColor = .blue
        return headerView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notescell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.layer.cornerRadius = 15
        if(indexPath.section == 0){
            cell.textLabel?.text = task!.point
        }else if(indexPath.section == 1){
            cell.textLabel?.text = task!.requirement
        }
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "☆ポイント"
        }else{
            return "必要なもの"
        }
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
