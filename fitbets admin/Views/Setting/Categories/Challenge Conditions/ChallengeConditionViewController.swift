//
//  ChallengeConditionViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class ChallengeConditionViewController: UIViewController {
    
     private var jsonDataChallengeList: [ChallegeDetail] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rules_lbl: UILabel!
    @IBOutlet weak var equipment_lbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllChallenges()
        // Do any additional setup after loading the view.
    }
    private  func getAllChallenges(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetChaConditionBySubCategoryId{
            (result) in
            switch result{
            case .success(let json):
                let jsonDataCondition = (json as! ConditionResponseModel).postTagDetails
               
                
                if  jsonDataCondition.rules.isEmpty {
                    self.rules_lbl.text = " "
                }
                else{
                    self.rules_lbl.text = jsonDataCondition.rules[0].rules
                }
                
                if jsonDataCondition.quipment.isEmpty {
                    self.equipment_lbl.text = " "
                }
                else {
                    self.tableView.reloadData()
                    self.equipment_lbl.text = jsonDataCondition.quipment[0].equipment
                }
                
                if jsonDataCondition.challegeDetails.isEmpty{
                                    print("No Challenge List")
                    print(jsonDataCondition.challegeDetails)
                    print("")
                }
                else
                {
                    self.jsonDataChallengeList = (json as! ConditionResponseModel).postTagDetails.challegeDetails
                    print("")
                    
                }
                //self.rules_lbl.text = jsonDataCondition.postTagDetails
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Condition List", message:  "No Condition Found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }
    
}

extension ChallengeConditionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataChallengeList.count
        //self.jsonDataAdmin.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ConditionCell", for: indexPath) as? ConditionTableViewCell {
            cell.challenge_name?.text = self.jsonDataChallengeList[indexPath.row].challengeName
            return cell
        }
        return UITableViewCell()
    }
    
}
