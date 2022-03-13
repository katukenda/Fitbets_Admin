//
//  DashboardViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-13.
//

import UIKit

class DashboardViewController: UIViewController {

   
    @IBOutlet weak var lbName: UILabel!
    var strName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        lbName.text = strName
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
       // APIManager.shareInstance.callingLogOutAPI(cv: self)
        
        TokenService.tokenInstance.removeToken()
        self.navigationController?.popToRootViewController(animated: true)
    }

}

//extension DashboardViewController{
//    static func shareInstance() -> DashboardViewController{
//        return DashboardViewController.instantiateFromStoryboard("Dashboard")
//    }
//}
