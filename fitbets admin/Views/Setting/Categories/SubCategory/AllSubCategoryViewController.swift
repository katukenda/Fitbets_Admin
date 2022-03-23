//
//  AllSubCategoryViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class AllSubCategoryViewController: UIViewController {

    private var jsonDataAllSubCategory: [AllSub] = []
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllSubCategory()
        // Do any additional setup after loading the view.
    }
    private  func getAllSubCategory(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetAllSubCategory{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataAllSubCategory = (json as! AllSubCategoryResponseModel).data
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Sub Category List", message:  "Items Not found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }

}

extension AllSubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.jsonDataAllSubCategory.count
        
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

            let selected_SubCat_id = self.jsonDataAllSubCategory[indexPath.row].id
            TokenService.tokenInstance.saveSubCategoryId(id: selected_SubCat_id)

                tableView.beginUpdates()
            jsonDataAllSubCategory.remove(at: indexPath.row)
                //start action

                    spinner.startAnimating()
                    APIManager.shareInstance.callDeleteSubCategoryById{
                        (result) in
                        switch result{
                        case .success(let json):
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.endUpdates()
                            let jsonData = (json as! DeleteResponseModel)
                            let alert = UIAlertController(title: "Sub Category Deleted", message: (jsonData.message), preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            self.present(alert, animated: true, completion: nil)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.spinner.stopAnimating()

                        case .failure(let err):
                            self.spinner.stopAnimating()
                            // create the alert
                            let alert = UIAlertController(title: "Sub Category Deleted", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)

                            print(err.localizedDescription)
                        }
                    }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AllSubCatCell", for: indexPath) as? AllSubCategoryTableViewCell {
            cell.subcategory_name.text = self.jsonDataAllSubCategory[indexPath.row].subcategoryName
            return cell
        }
        return UITableViewCell()
    }
}
