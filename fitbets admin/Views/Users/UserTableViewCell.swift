//
//  UserTableViewCell.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-17.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
