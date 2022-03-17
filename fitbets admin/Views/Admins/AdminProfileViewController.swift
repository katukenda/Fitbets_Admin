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
                  let alert = UIAlertController(title: "Fitbets Profile Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                  print(err.localizedDescription)
              }
          }
      }

    @IBAction func deleteAdmin(_ sender: Any) {
    }
    
}
