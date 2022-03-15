//
//  EditProfieViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-15.
//

import UIKit

class EditProfieViewController: UIViewController {
    
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newMobile: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newName.text = TokenService.tokenInstance.getName()
        self.newEmail.text = TokenService.tokenInstance.getEmail()
        self.newMobile.text = TokenService.tokenInstance.getMobile()
    }
    //dismiss keaboard when touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
        
    }
    
    func validateFields(){
        if newName.text?.isEmpty == true {
            self.errorMessage.text = "No admin Name input"
            return
        }
        if newEmail.text?.isEmpty == true {
            self.errorMessage.text = "No Email input"
            return
        }
        if newMobile.text?.isEmpty == true {
            self.errorMessage.text = "No Mobile input"
            return
        }
        
        self.errorMessage.text = " "
        self.updateProfile()
    }
    
    func updateProfile(){
        spinner.startAnimating()
        guard let newName = newName.text else { return }
        guard let newEmail = newEmail.text else { return }
        guard let newMobile = newMobile.text else { return }
        
        
        
        let updateProfile = UpdateProfileModel(admin_name: newName, email_address: newEmail, mobile_number: newMobile)
        APIManager.shareInstance.callUpdateProfile(updateProfile: updateProfile) {
            (result) in
            switch result{
            case .success(let json):
                print(json)
                let adminName = (json as! ProfileUpdateresponse).data.adminName
                let email_address = (json as! ProfileUpdateresponse).data.emailAddress
                let mobile_number = (json as! ProfileUpdateresponse).data.mobileNumber
                let userId = TokenService.tokenInstance.getId()
                
                TokenService.tokenInstance.saveProfileDeatails(name: adminName, email: email_address, mobile: mobile_number, id: userId)
                
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  (json as! ProfileUpdateresponse).message, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                self.spinner.stopAnimating()
                
                
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        validateFields()
    }
    
    
    
}
