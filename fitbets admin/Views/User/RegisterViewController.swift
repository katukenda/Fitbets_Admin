//
//  RegisterViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-12.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var adminName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
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
            print("No admin Name input")
            return
        }
        if email.text?.isEmpty == true {
            print("No email  input")
            return
        }
        if mobileNumber.text?.isEmpty == true {
            print("No mobile number  input")
            return
        }
        if password.text?.isEmpty == true {
            print("No password input")
            return
        }
        if confirmPassword.text?.isEmpty == true {
            print("No confirm password input")
            return
        }
        
        if password.text != confirmPassword.text {
            print("Password Dismatch")
            return
        }
        self.registerAdmin()
    }
    
    //register function
    func registerAdmin(){
        
        guard let admin_name = adminName.text else { return }
        guard let e_mail = email.text else { return }
        guard let mobile_number = mobileNumber.text else { return }
        guard let password_input = password.text else { return }
        
        let register = RegisterModel(admin_name: admin_name, email_address: e_mail, mobile_number: mobile_number, password: password_input, device_token: device_token)
            APIManager.shareInstance.callRegisterAPI(register: register)
    }

}
