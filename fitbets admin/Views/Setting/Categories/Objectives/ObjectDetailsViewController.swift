//
//  ObjectDetailsViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import UIKit

class ObjectDetailsViewController: UIViewController {

    var categoryId : Int = 0
    var subcategoryId: Int = 0
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var objective_name: UILabel!
    @IBOutlet weak var new_object_name: UITextField!
    @IBOutlet weak var error_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getObjectiveDetails()
        // Do any additional setup after loading the view.
    }
    
    private  func getObjectiveDetails(){
        spinner.startAnimating()
        APIManager.shareInstance.callGetObjectiveById{
            (result) in
            switch result{
            case .success(let json):
                let jsonDataObjective = (json as! ObjectDetailsResponseModel).data
                self.objective_name.text = jsonDataObjective[0].objectiveName
                self.categoryId = jsonDataObjective[0].categoryID
                self.subcategoryId = jsonDataObjective[0].subCategoryID
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Objectives Details", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }

    
    func validateFields(){
        if new_object_name.text?.isEmpty == true {
            self.error_label.text = "No Object Name input"
            return
        }
        
        self.error_label.text = " "
        self.updateObject()
    }
    
    func updateObject(){
        spinner.startAnimating()
        guard let newObject = new_object_name.text else { return }
     
        
        
        let updateObject = ObjectRequestModel(categoryID: self.categoryId, subCategoryID: self.subcategoryId, objectiveName: newObject)
        APIManager.shareInstance.callUpdateObjective(updateObjective: updateObject) {
            (result) in
            switch result{
            case .success(let json):
                print(json)
                self.objective_name.text = (json as! ObjectUpdateResponseModel).data.objectiveName
               
                
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  (json as! ObjectUpdateResponseModel).message, preferredStyle: UIAlertController.Style.alert)
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
    
    
    @IBAction func updateTapped(_ sender: Any) {
        self.validateFields()
    }
}
