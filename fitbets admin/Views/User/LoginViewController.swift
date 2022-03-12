//
//  LoginViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-12.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var adminName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //dismiss keaboard when touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //login button
    @IBAction func LoginButton(_ sender: Any) {
        
        validateFields()
    }
    
    //validate input fields
    
    func validateFields(){
        if adminName.text?.isEmpty == true {
            print("No admin Name input")
            return
        }
        if password.text?.isEmpty == true {
            print("No password input")
            return
        }
        self.loginAdmin()
    }
    
    // login function
    func loginAdmin() {
        
        guard let admin_name = adminName.text else { return }
        
        guard let password_input = password.text else { return }
        
        let login = LoginModel(admin_name: admin_name, password: password_input, device_token: device_token)
        APIManager.shareInstance.callLoginAPI(login: login)
        
    }
    
    //go to register page
    @IBAction func goToRegisterView(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "register") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
