//
//  AdminViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit
import Alamofire

 final class AdminViewController: UIViewController {

     private var jsonDataAdmin: [Datum] = []
     
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView_height: NSLayoutConstraint!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getAllAdmin()
    }
                            
    
  private  func getAllAdmin(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetAllAdmin{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataAdmin = (json as! GetAllAdminResponseModel).data
                self.tableView.reloadData()
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
 }



extension AdminViewController: UITableViewDelegate, UITableViewDataSource{
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataAdmin.count
        //self.jsonDataAdmin.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected_admin_id = self.jsonDataAdmin[indexPath.row].id
        TokenService.tokenInstance.saveAdminId(id: selected_admin_id)
        
        let viewAdminProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AdminProfileViewController") as? AdminProfileViewController
        viewAdminProfileVC?.selected_A_ID = "\(selected_admin_id)"
        //loginVC?.strName = adminName
        self.navigationController?.pushViewController(viewAdminProfileVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCell", for: indexPath) as? AdminTableViewCell {
           cell.admin_name.text = self.jsonDataAdmin[indexPath.row].emailAddress
           return cell
        }
        return UITableViewCell()
    }
    
}
    
