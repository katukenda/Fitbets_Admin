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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
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
        spinner.startAnimating()
        guard let admin_name = adminName.text else { return }
        
        guard let password_input = password.text else { return }
        
        let login = LoginModel(admin_name: "katukenda2", password: "pass@1234", device_token: device_token)
        APIManager.shareInstance.callLoginAPI(login: login) { (result) in
            switch result{
            case .success(let json):
                print(json)
                let adminName = (json as! LoginResponseModel).sub.adminName
                let email_address = (json as! LoginResponseModel).sub.emailAddress
                let mobile_number = (json as! LoginResponseModel).sub.mobileNumber
                let admin_id = (json as! LoginResponseModel).sub.id
                let userToken = (json as! LoginResponseModel).token
                TokenService.tokenInstance.saveToken(token: userToken)
                TokenService.tokenInstance.saveProfileDeatails(name: adminName, email: email_address, mobile: mobile_number, id: admin_id)
                //go to dashboard
                self.spinner.stopAnimating()
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Login", message: "something ent wrong. Please try again!", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                print(err.localizedDescription)
            }
        }
        
    }
    
    //go to register page
    @IBAction func goToRegisterView(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
                self.present(newViewController, animated: true, completion: nil)
    }
    
    
}
