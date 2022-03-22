//
//  SubCategoryDetailsViewController.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class SubCategoryDetailsViewController: UIViewController {

    var subCat_titile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.subCat_titile
        
    }
    @IBAction func goToChallenges(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChallengesViewController") as! ChallengesViewController
        self.present(next, animated: true, completion: nil)
    }
    
    @IBAction func goToConditions(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChallengeConditionViewController") as!
        ChallengeConditionViewController
        self.present(next, animated: true, completion: nil)
    }
    }



