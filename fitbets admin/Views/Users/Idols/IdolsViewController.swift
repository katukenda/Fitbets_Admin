//
//  IdolsViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class IdolsViewController: UIViewController {
    private var jsonIdolsList: [GIBUID] = []
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.getAllIdols()
        self.tableView.reloadData()
    }
    private  func getAllIdols(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetIdolsByUserId{
            (result) in
            switch result{
            case .success(let json):
                self.jsonIdolsList = (json as! GetIdolsByIdModel).data
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Idols List", message:  "No Idols for this User", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }
}

extension IdolsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonIdolsList.count
        
        //self.jsonDataAdmin.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selected_user_id = self.jsonDataUser[indexPath.row].id
//        TokenService.tokenInstance.saveAdminId(id: selected_user_id)
//
//        let viewUserProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
//        self.navigationController?.pushViewController(viewUserProfileVC!, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IdolsCell", for: indexPath) as? IdolsTableViewCell {
            cell.idol_name.text = self.jsonIdolsList[indexPath.row].username
            return cell
        }
        return UITableViewCell()
    }
}
