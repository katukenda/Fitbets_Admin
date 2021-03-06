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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
                self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func gotoCategoryTap(_ sender: Any) {
        let CVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        self.navigationController?.pushViewController(CVC!, animated: true)
    }
    
    
    @IBAction func gotoSubCategoryTaped(_ sender: Any) {
        let ASC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AllSubCategoryViewController") as? AllSubCategoryViewController
        self.navigationController?.pushViewController(ASC!, animated: true)
        
    }
    @IBAction func gotoObjectiveTapped(_ sender: Any) {
        let GTO = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ObjectivesViewController") as? ObjectivesViewController
        self.navigationController?.pushViewController(GTO!, animated: true)
        
    }
}
