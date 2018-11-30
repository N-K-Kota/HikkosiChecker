//
//  TopPageViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/21.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit
var checkedObj:CheckedObj?
var uncheckedObj:UncheckedObj?
var progressive:Progressive?
var allAddresses = AllAddresses()
class TopPageViewController: UIViewController {
    @IBOutlet weak var plannedStack: UIStackView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var plannedDateLabel: UILabel!
    @IBOutlet weak var leftDateLabel: UILabel!
    @IBOutlet weak var perProgressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progImageView: UIImageView!
    @IBOutlet weak var settingStack: UIStackView!
    @IBOutlet weak var progressStack: UIStackView!
    var progressVal:Int?
    var plannedDate = PlannedDate()
    override func viewDidLoad() {
        super.viewDidLoad()
            progressive = Progressive(0.0)
            progressive!.read()
            progressView.setProgress(progressive!.ratio, animated: false)
            perProgressLabel.text = "\(progressView.progress*100)%"
            plannedDate.readDate()
           plannedStack.translatesAutoresizingMaskIntoConstraints = false
           leftDatesStack.translatesAutoresizingMaskIntoConstraints = false
           progressStack.translatesAutoresizingMaskIntoConstraints = false
           settingStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var leftDatesStack: UIStackView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let x = progressive!.ratio * Float(progressView.frame.width)
        let transform = CGAffineTransform(translationX: CGFloat(x)-progImageView.frame.width/2, y: 0)
        progImageView.transform = transform
        /*let parentW = self.view.frame.width
        plannedStack.frame = CGRect(x: (parentW-plannedStack.frame.width)/2, y: 50, width: 300, height:100 )
        leftDatesStack.frame = CGRect(x: (parentW-leftDatesStack.frame.width)/2, y: plannedStack.frame.maxY+50, width: 250, height: 80)
        progressStack.frame = CGRect(x: (parentW-progressStack.frame.width)/2, y: leftDatesStack.frame.maxY+100, width: 300, height: 120)
        settingStack.frame = CGRect(x: (parentW-settingStack.frame.width)/2, y: progressStack.frame.maxY+10, width: 60, height: 100)*/
        let allspace = UIScreen.main.bounds.height - (plannedStack.frame.height + leftDatesStack.frame.height + progressStack.frame.height + settingStack.frame.height)
        let plannedtop = allspace/5+20
        let ltop = allspace/5-20
        let progresstop = allspace/5-10
        let stop = allspace/5
        
        let stackX = (self.view.frame.width-plannedStack.frame.width)/2
        plannedStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: plannedtop).isActive = true
        plannedStack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:stackX).isActive = true
        //plannedStack.widthAnchor.constraint(equalToConstant: plannedStack.frame.width).isActive = true
        leftDatesStack.topAnchor.constraint(equalTo: plannedStack.bottomAnchor, constant: ltop).isActive = true
        leftDatesStack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width-leftDatesStack.frame.width)/2).isActive = true
        //leftDatesStack.widthAnchor.constraint(equalToConstant: 250).isActive = true
        progressStack.topAnchor.constraint(equalTo: leftDatesStack.bottomAnchor, constant: progresstop).isActive = true
        progressStack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width-progressStack.frame.width)/2).isActive = true
        //progressStack.widthAnchor.constraint(equalToConstant: 300).isActive = true
        settingStack.topAnchor.constraint(equalTo: progressStack.bottomAnchor, constant: stop).isActive = true
        settingStack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width-settingStack.frame.width)/2).isActive = true
        //settingStack.widthAnchor.constraint(equalToConstant: 80)
    }
    override func viewWillAppear(_ animated: Bool) {
        plannedDateLabel.text = plannedDate.toString()
        leftDateLabel.text = plannedDate.leftDates()
        progressView.setProgress(progressive!.ratio, animated: true)
        perProgressLabel.text = "\(progressView.progress*100)%"
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "tosetting"){
            let vc = segue.destination as! SettingViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.defaultDate = plannedDate.date
        }
    }

}
