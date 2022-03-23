//
//  ObjectivesViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-18.
//

import UIKit

class ObjectivesViewController: UIViewController {
    private var jsonDataObjective: [GetAllObjective] = []
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllObjectives()
        // Do any additional setup after loading the view.
    }
    
    private  func getAllObjectives(){
        spinner.startAnimating()
        APIManager.shareInstance.callGetAllObjective{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataObjective = (json as! GetAllObjectiveResponseModel).data
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
}

extension ObjectivesViewController: UITableViewDelegate, UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selected_objective_id = self.jsonDataObjective[indexPath.row].id
        TokenService.tokenInstance.saveCommonId(id: selected_objective_id)

        let OVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ObjectDetailsViewController") as? ObjectDetailsViewController
        self.navigationController?.pushViewController(OVC!, animated: true)
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
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectiveCell", for: indexPath) as? ObjectiveTableViewCell {
           cell.objective_name.text = self.jsonDataObjective[indexPath.row].objectiveName
           return cell
        }
        return UITableViewCell()
    }
    
}
    

