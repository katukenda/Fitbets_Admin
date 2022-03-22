//
//  AdminDetailsViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-17.
//

import UIKit

class AdminProfileViewController: UIViewController {
    
    var selected_A_ID = ""
    
    
    @IBOutlet weak var admin_name: UILabel!
    @IBOutlet weak var admin_email: UILabel!
    @IBOutlet weak var admin_mobile: UILabel!
    
    @IBOutlet weak var profileCard: UIImageView!
    @IBOutlet weak var delete_msglbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getAdminDetail()
        
    }
    
    private  func getAdminDetail(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetAdminById{
            (result) in
            switch result{
            case .success(let json):
                let jsonDataAdmin = (json as! GetAdminProfileDataResponseModel).data
                self.admin_name.text = jsonDataAdmin[0].adminName
                self.admin_email.text = jsonDataAdmin[0].emailAddress
                self.admin_mobile.text = jsonDataAdmin[0].mobileNumber
                
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
               
                print(err.localizedDescription)
            }
        }
        
    }
    
    
    @IBAction func deleteAdminButton(_ sender: Any) {
        let id_new  = Int(TokenService.tokenInstance.getId())
        let id_admin = Int(selected_A_ID)
        
        if id_new != id_admin
        {
            let alertController = UIAlertController(title: "Delete Alert!", message: "Are you sure to delete this admin", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                self.deleteAdmin()
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                // ...
            }
            
            
        }
        else {
            let alert = UIAlertController(title: "Fitbets Profile Update", message: "You Cant delete Your self heare ", preferredStyle: UIAlertController.Style.alert)
        }
    }
    
    
    public func deleteAdmin() {
        spinner.startAnimating()
        APIManager.shareInstance.callDeleteAdminById{
            (result) in
            switch result{
            case .success(let json):
                let jsonData = (json as! DeleteAdminModel)
                let alert = UIAlertController(title: "Admin Deleted", message: (jsonData.message), preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.spinner.stopAnimating()
                self.admin_name.text = ""
                self.admin_email.text = ""
                self.admin_mobile.text = ""
                self.delete_msglbl.text = "Acount Deleted !"
                self.delete_msglbl.isUserInteractionEnabled = true
                 
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Admin Delete", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print(err.localizedDescription)
            }
        }
    }
}



