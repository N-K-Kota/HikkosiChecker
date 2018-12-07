//
//  assertionView.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/07.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class assertionView: UIViewController {
    var url:String?
    @IBOutlet weak var urlLabel: UILabel!
    var jump = {()->Void in }
    override func viewDidLoad() {
        super.viewDidLoad()
            urlLabel.text = url
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        jump()
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
