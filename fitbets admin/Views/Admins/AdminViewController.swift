//
//  AdminViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit

class AdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.checkOlredyLogged()
        // Do any additional setup after loading the view.
    }
    
    func checkOlredyLogged(){
        if TokenService.tokenInstance.checkForLogin(){
print("Token Have")
   }
        else {
            
            print("Token don't have")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
 

}
