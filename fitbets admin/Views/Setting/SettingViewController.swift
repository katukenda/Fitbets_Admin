//
//  SettingViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        TokenService.tokenInstance.removeToken()
        TokenService.tokenInstance.removeProfileDeatails()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
