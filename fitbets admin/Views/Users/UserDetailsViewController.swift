//
//  UserDetailsViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-18.
//

import UIKit

class UserDetailsViewController:UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var profileCard: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getUserDetail()
    }
    private  func getUserDetail(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetuserById{
            (result) in
            switch result{
            case .success(let json):
                let jsonDataUser = (json as! GetUserDetailsModel).data
                self.userName.text = jsonDataUser[0].userName
                self.userEmail.text = jsonDataUser[0].userEmail
//
                let url = URL(string: jsonDataUser[0].plyCarURL)
                let data = try? Data(contentsOf: url!)
                              //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                              self.profileCard.image = UIImage(data: data!)
                
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                 //create the alert
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
               
                print(err.localizedDescription)
            }
        }
        
    }
    
    
    
    @IBAction func userDeleteTapped(_ sender: Any) {
       
            let alertController = UIAlertController(title: "Delete Alert!", message: "Are you sure to delete this user", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                self.deleteUser()
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                // ...
            }
            
            
    }
    
    
    
    private func deleteUser() {
        spinner.startAnimating()
        APIManager.shareInstance.callDeleteUserById{
            (result) in
            switch result{
            case .success(let json):
                let jsonData = (json as! DeleteUserModel)
                let alert = UIAlertController(title: "User Deleted", message: (jsonData.message), preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.spinner.stopAnimating()
                self.userName.text = ""
                self.userEmail.text = ""
              
                 
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets User Delete", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print(err.localizedDescription)
            }
        }
    }
    

}
