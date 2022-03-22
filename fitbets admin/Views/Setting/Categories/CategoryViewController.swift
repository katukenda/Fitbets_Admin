//
//  CategoryViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-18.
//

import UIKit

class CategoryViewController: UIViewController {
    private var jsonDataAllCategory: [GAC] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllCatagory()
        // Do any additional setup after loading the view.
    }
 
    
    private  func getAllCatagory(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetAllCategory{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataAllCategory = (json as! GetCategoryResponsModel).data
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Category List", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }
    
}
    
    extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.jsonDataAllCategory.count
            //self.jsonDataAdmin.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let selected_category_id = self.jsonDataAllCategory[indexPath.row].id
            TokenService.tokenInstance.saveCategoryId(id: selected_category_id)

            let viewSubCatVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategoryViewController") as? SubCategoryViewController
            viewSubCatVC?.cat_titile = jsonDataAllCategory[indexPath.row].categoryName
            self.navigationController?.pushViewController(viewSubCatVC!, animated: true)
        }
        
      
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           if let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath) as? CategoryTableViewCell {
               cell.catagoryCellName.text = jsonDataAllCategory[indexPath.row].categoryName
               return cell
            }
            return UITableViewCell()
        }
        
    }
        

