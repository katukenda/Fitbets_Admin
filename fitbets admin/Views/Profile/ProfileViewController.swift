//
//  ProfileViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var adminNameLb: UILabel!
    @IBOutlet weak var adminEmailLb: UILabel!
    
    @IBOutlet weak var nameBackgroound: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadView()
        self.checkAlredyLogged()
    }
    
    func checkAlredyLogged(){
        if TokenService.tokenInstance.checkForLogin(){
//            let loginVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "admin") as? AdminViewController
//            self.navigationController?.pushViewController(loginVC!, animated: true)
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
   }
        else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
                            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func represhtapped(_ sender: Any) {
        self.reloadView()
    }
    func reloadView(){
        spinner.startAnimating()
        DispatchQueue.main.async {
            self.adminNameLb.text = TokenService.tokenInstance.getName()
            self.adminEmailLb.text = TokenService.tokenInstance.getEmail()
                }
        spinner.stopAnimating()
        //self.adminEmailLb.text = "\(TokenService.tokenInstance.getId())"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoEditprofile(_ sender: Any) {
        let editPF = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "edit_profile") as? EditProfieViewController
        //loginVC?.strName = adminName
        self.navigationController?.pushViewController(editPF!, animated: true)
    }
    
    
}
