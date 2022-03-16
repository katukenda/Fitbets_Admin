//
//  AdminViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-14.
//

import UIKit
import Alamofire

final class AdminViewController: UIViewController {

    
    @IBOutlet private weak var tableView: UITableView!
   
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getAllAdmin()
    }
                            
    
    func getAllAdmin(){
        spinner.startAnimating()
        
        APIManager.shareInstance.callgetAllAdmin{
            (result) in
            switch result{
            case .success(let json):
                print(json)
                self.spinner.stopAnimating()

            case .failure(let err):
                self.spinner.stopAnimating()
                // create the alert
                let alert = UIAlertController(title: "Fitbets Profile Update", message:  err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(err.localizedDescription)
            }
        }
    }
}

    
