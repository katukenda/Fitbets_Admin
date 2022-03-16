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
