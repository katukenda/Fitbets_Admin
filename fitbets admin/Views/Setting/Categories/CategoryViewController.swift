//
//  CategoryViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-18.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
}
    
    extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
        
     
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
            //self.jsonDataAdmin.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//            let selected_admin_id = self.jsonDataAdmin[indexPath.row].id
//            TokenService.tokenInstance.saveAdminId(id: selected_admin_id)
//
//            let viewAdminProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AdminProfileViewController") as? AdminProfileViewController
//            viewAdminProfileVC?.selected_A_ID = "\(selected_admin_id)"
//            //loginVC?.strName = adminName
//            self.navigationController?.pushViewController(viewAdminProfileVC!, animated: true)
//        }
        
        
   
      
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           if let cell = tableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath) as? CategoryTableViewCell {
               cell.catagoryCellName.text = "Dummy "
               return cell
            }
            return UITableViewCell()
        }
        
    }
        

