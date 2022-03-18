//
//  UsersViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit

class UsersViewController: UIViewController {
    private var jsonDataUser: [GAUList] = []
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        self.userTableView.reloadData()
        self.getAllAdmin()
        
    }
    
    
    private  func getAllAdmin(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetAllUsers{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataUser = (json as! GetAllUserRequestModel).data
                self.userTableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets User List", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataUser.count
        
        //self.jsonDataAdmin.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let selected_user_id = self.jsonDataUser[indexPath.row].id
            TokenService.tokenInstance.saveAdminId(id: selected_user_id)
           
                tableView.beginUpdates()
                jsonDataUser.remove(at: indexPath.row)
                //start action
                
                    spinner.startAnimating()
                    APIManager.shareInstance.callDeleteUserById{
                        (result) in
                        switch result{
                        case .success(let json):
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.endUpdates()
                            let jsonData = (json as! DeleteUserModel)
                            let alert = UIAlertController(title: "User Deleted", message: (jsonData.message), preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            self.present(alert, animated: true, completion: nil)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.spinner.stopAnimating()
                          
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected_user_id = self.jsonDataUser[indexPath.row].id
        TokenService.tokenInstance.saveAdminId(id: selected_user_id)
        
        let viewUserProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
        self.navigationController?.pushViewController(viewUserProfileVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell {
            cell.userName.text = self.jsonDataUser[indexPath.row].userName
            return cell
        }
        return UITableViewCell()
    }
}
