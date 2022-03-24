//
//  CreateObjectiveViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import UIKit

class CreateObjectiveViewController: UIViewController {
    private var jsonDataObjective: [GOBCID] = []
    @IBOutlet weak var error_lbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var objective_input: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var objective_time: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllObjectivesByCatId()
        // Do any additional setup after loading the view.
    }
    func validateFields(){
        if objective_input.text?.isEmpty == true {
            self.error_lbl.text = "No Object Name input"
            return
        }
        if objective_time.text?.isEmpty == true {
            self.error_lbl.text = "No Object Time input"
            return
        }
        
        self.error_lbl.text = " "
        self.CreateObject()
    }
    
    func CreateObject(){
        spinner.startAnimating()
        guard let newObject = objective_input.text else { return }
        guard let newObjectTime = objective_time.text else { return }
     
        let cat_id = TokenService.tokenInstance.getCategoryId()
        let subCat_id = TokenService.tokenInstance.getSubCategoryId()
        
        
        let createObject = ObjectRequestModel(categoryID: cat_id, subCategoryID: subCat_id, objectiveName: newObject, objectiveTime: newObjectTime)
        APIManager.shareInstance.callCreateObjective(createObjective: createObject) {
            (result) in
            switch result{
            case .success(let json):
                print(json)
                self.objective_input.text = ""
                self.objective_time.text = ""
                self.getAllObjectivesByCatId()
                let alert = UIAlertController(title: "Fitbets Object Create", message:  (json as! ObjectCreateResponseModel).message, preferredStyle: UIAlertController.Style.alert)
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
    private  func getAllObjectivesByCatId(){
        spinner.startAnimating()
        APIManager.shareInstance.callDeleteCategoryById{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataObjective = (json as! GetObjectByCatIDResponseModel).data
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Objectives List", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
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
extension CreateObjectiveViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataObjective.count
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

            let selected_objective_id = self.jsonDataObjective[indexPath.row].id
            TokenService.tokenInstance.saveCommonId(id: selected_objective_id)

                tableView.beginUpdates()
            jsonDataObjective.remove(at: indexPath.row)
                //start action

                    spinner.startAnimating()
                    APIManager.shareInstance.callDeleteCategoryById{
                        (result) in
                        switch result{
                        case .success(let json):
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.endUpdates()
                            let jsonData = (json as! DeleteResponseModel)
                            let alert = UIAlertController(title: "Objective Deleted", message: (jsonData.message), preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            self.present(alert, animated: true, completion: nil)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.spinner.stopAnimating()

                        case .failure(let err):
                            self.spinner.stopAnimating()
                            // create the alert
                            let alert = UIAlertController(title: "Objective Deleted", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)

                            print(err.localizedDescription)
                        }
                    }
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectiveByIdCell", for: indexPath) as? ObjectiveByIdTableViewCell {
           cell.objective_name.text = self.jsonDataObjective[indexPath.row].objectiveName
           return cell
        }
        return UITableViewCell()
    }
    
}
    

