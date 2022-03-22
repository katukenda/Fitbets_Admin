//
//  SubCategoryViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-21.
//

import UIKit

class SubCategoryViewController: UIViewController {
    var cat_titile = ""
    private var jsonDataAllSubCategory: [GASC] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.cat_titile
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllSubCategory()
        // Do any additional setup after loading the view.
    }
    private  func getAllSubCategory(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetSubCategoryById{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataAllSubCategory = (json as! GetSubCategoryResponsModel).data
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

extension SubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataAllSubCategory.count
        //self.jsonDataAdmin.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selected_subCat_id = self.jsonDataAllSubCategory[indexPath.row].id
        TokenService.tokenInstance.saveSubCategoryId(id: selected_subCat_id)

        let viewSubCategoryDetailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        viewSubCategoryDetailsVC?.subCat_titile = jsonDataAllSubCategory[indexPath.row].subcategoryName
        self.navigationController?.pushViewController(viewSubCategoryDetailsVC!, animated: true)
    }
    
    

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategory", for: indexPath) as? SubCategoryTableViewCell {
           cell.suCategory_name.text =  jsonDataAllSubCategory[indexPath.row].subcategoryName
           return cell
        }
        return UITableViewCell()
    }
    
}
    
