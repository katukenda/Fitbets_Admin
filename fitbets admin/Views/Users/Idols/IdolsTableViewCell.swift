//
//  IdolsTableViewCell.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class IdolsTableViewCell: UITableViewCell {

    @IBOutlet weak var idol_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension IdolsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
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
//        let selected_user_id = self.jsonDataUser[indexPath.row].id
//        TokenService.tokenInstance.saveAdminId(id: selected_user_id)
//
//        let viewUserProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
//        self.navigationController?.pushViewController(viewUserProfileVC!, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IdolsCell", for: indexPath) as? IdolsTableViewCell {
            cell.idol_name.text = "J"
            return cell
        }
        return UITableViewCell()
    }
}
