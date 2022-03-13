//
//  LoginViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-12.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var error_message: UILabel!
    
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
            self.error_message.text = "No admin Name input"
            return
        }
        if password.text?.isEmpty == true {
            self.error_message.text = "No password input"
            return
        }
        self.error_message.text = " "
        self.loginAdmin()
    }
    
    // login function
    func loginAdmin() {
        
        guard let admin_name = adminName.text else { return }
        
        guard let password_input = password.text else { return }
        
        let login = LoginModel(admin_name: admin_name, password: password_input, device_token: device_token)
        APIManager.shareInstance.callLoginAPI(login: login) { (result) in
            switch result{
            case .success(let json):
                print(json)
                let adminName = (json as! LoginResponseModel).sub.adminName
                let userToken = (json as! LoginResponseModel).token
                TokenService.tokenInstance.saveToken(token: userToken)
                //go to dashboard
                let DashboardVC = UIStoryboard.init(name: "Dashboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
                DashboardVC?.strName = adminName
                self.navigationController?.pushViewController(DashboardVC!, animated: true)
                
                //                let email = (json as AnyObject).value(forKey: "token") as! String
                //                let adminName = (json as AnyObject).value(forKey: "expiresIn") as! String
                //
                //                let loginResponse = LoginResponseModel(name: adminName, email: email)
                //                self.error_message.text = email
                //                print(loginResponse)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    //go to register page
    @IBAction func goToRegisterView(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "register") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
