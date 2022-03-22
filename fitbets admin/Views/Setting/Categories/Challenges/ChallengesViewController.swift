//
//  ChallengesViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class ChallengesViewController: UIViewController {
    private var jsonDataChallengesBySubID: [GACBS] = []
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.getAllChallenges()
    }
    private  func getAllChallenges(){
        spinner.startAnimating()
        APIManager.shareInstance.callgetChallengeBySubCategoryId{
            (result) in
            switch result{
            case .success(let json):
                self.jsonDataChallengesBySubID = (json as! GetAllChallengesResponseModel).data
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Challenge List", message:  "No Challenge", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }

}

extension ChallengesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonDataChallengesBySubID.count
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
//        let selected_category_id = self.jsonDataAllCategory[indexPath.row].id
//        TokenService.tokenInstance.saveCategoryId(id: selected_category_id)
//
//        let viewSubCatVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategoryViewController") as? SubCategoryViewController
//        viewSubCatVC?.cat_titile = jsonDataAllCategory[indexPath.row].categoryName
//        self.navigationController?.pushViewController(viewSubCatVC!, animated: true)
//    }
//
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeCell", for: indexPath) as? ChallengesTableViewCell {
           cell.challenge_name?.text = self.jsonDataChallengesBySubID[indexPath.row].challengeName
           cell.object_lbl?.text = self.jsonDataChallengesBySubID[indexPath.row].object
           let time_seconds = Double(self.jsonDataChallengesBySubID[indexPath.row].time)
           cell.time_lbl?.text = "\(time_seconds)" + " mili-seconds"
           return cell
        }
        return UITableViewCell()
    }
    
}
