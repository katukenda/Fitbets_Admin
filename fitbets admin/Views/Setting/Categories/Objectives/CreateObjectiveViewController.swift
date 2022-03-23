//
//  CreateObjectiveViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import UIKit

class CreateObjectiveViewController: UIViewController {

    @IBOutlet weak var error_lbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var objective_input: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func validateFields(){
        if objective_input.text?.isEmpty == true {
            self.error_lbl.text = "No Object Name input"
            return
        }
        
        self.error_lbl.text = " "
        self.CreateObject()
    }
    
    func CreateObject(){
        spinner.startAnimating()
        guard let newObject = objective_input.text else { return }
     
        let cat_id = TokenService.tokenInstance.getCategoryId()
        let subCat_id = TokenService.tokenInstance.getSubCategoryId()
        
        
        let createObject = ObjectRequestModel(categoryID: cat_id, subCategoryID: subCat_id, objectiveName: newObject)
        APIManager.shareInstance.callCreateObjective(createObjective: createObject) {
            (result) in
            switch result{
            case .success(let json):
                print(json)
                self.objective_input.text = ""
                let alert = UIAlertController(title: "Fitbets Object Create", message:  (json as! ObjectUpdateResponseModel).message, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                self.spinner.stopAnimating()
                
                
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Objective Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                print(err.localizedDescription)
            }
        }
    }

    
    @IBAction func create_tapped(_ sender: Any) {
        self.validateFields()
    }
    
    
}
