//
//  HomeViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit

class HomeViewController: UIViewController {
    var strName = ""
    
    @IBOutlet weak var lbName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbName.text = strName
        self.title = "Home"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
 
   
    @IBAction func logOut(_ sender: Any) {
        
        // APIManager.shareInstance.callingLogOutAPI(cv: self)
               TokenService.tokenInstance.removeToken()
               self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func nextTest(_ sender: Any) {
        if let tabBar = presentingViewController as? UITabBarController {
               tabBar.selectedIndex = 1
           }
           dismiss(animated: true)
        
    }
    
    
}
