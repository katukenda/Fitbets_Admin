//
//  RegisterViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-12.
//

import UIKit

class RegisterViewController: UIViewController, UIAlertViewDelegate {
    
    
    //let error_message = ""
    
    @IBOutlet weak var error_message: UILabel!
    
    @IBOutlet weak var adminName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //dismiss keaboard when touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //register
    
    @IBAction func registerButton(_ sender: Any) {
       
        validateFields()
    }
    
    func validateFields(){
        if adminName.text?.isEmpty == true {
            self.error_message.text = "No admin Name input"
            
            return
        }
        if email.text?.isEmpty == true {
            self.error_message.text = "No email  input"
            return
        }
        if mobileNumber.text?.isEmpty == true {
            self.error_message.text = "No mobile number  input"
            return
        }
        if password.text?.isEmpty == true {
            self.error_message.text = "No password input"
            return
        }
        if confirmPassword.text?.isEmpty == true {
            self.error_message.text = "No confirm password input"
            return
        }
        
        if password.text != confirmPassword.text {
            self.error_message.text = "Password Dismatch"
            return
        }
        self.error_message.text = ""
        self.registerAdmin()
    }
    
    //register function
    func registerAdmin(){
        spinner.startAnimating()
        guard let admin_name = adminName.text else { return }
        guard let e_mail = email.text else { return }
        guard let mobile_number = mobileNumber.text else { return }
        guard let password_input = password.text else { return }
        
        let register = RegisterModel(admin_name: admin_name, email_address: e_mail, mobile_number: mobile_number, password: password_input, device_token: device_token)
        APIManager.shareInstance.callRegisterAPI(register: register)
        {
            
            (isSuccess, str) in
            if isSuccess == true {
                
               
                self.spinner.stopAnimating()
                let alertController = UIAlertController(title: "Register Alert!", message: str, preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "New Register", style: .cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "Login", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // ...
                }
            }
            else {
                self.spinner.stopAnimating()
                let alert = UIAlertController(title: "Fitbets Admin Register", message:  str, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                    // ...
                }
            
        }
    }
    
    
    @IBAction func backToLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
           dismiss(animated: true, completion: nil)
    }
    
}
