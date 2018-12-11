//
//  assertionView.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/07.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class assertionView: UIViewController {
    @IBOutlet weak var expressLabel: UILabel!
    var url:String?
    @IBOutlet weak var urlLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
            urlLabel.text = url
            self.view.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        if let ur = NSURL(string: url!){
        if(UIApplication.shared.canOpenURL(ur as URL)){
            self.dismiss(animated: true, completion: nil)
            UIApplication.shared.open(ur as URL, options:[UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:UIApplication.OpenExternalURLOptionsKey.universalLinksOnly] , completionHandler: nil)
        }else{
            yesBtn.isEnabled = false
            yesBtn.layer.opacity = 0
            expressLabel.text = "は無効なURLです"
            expressLabel.textColor = .red
            noBtn.setTitle("閉じる", for: .normal)
        }
        }else{
            yesBtn.isEnabled = false
            yesBtn.layer.opacity = 0
            expressLabel.text = "は無効なURLです"
            expressLabel.textColor = .red
            noBtn.setTitle("閉じる", for: .normal)
        }
    }
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
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
