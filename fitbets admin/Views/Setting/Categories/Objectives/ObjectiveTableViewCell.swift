//
//  ObjectiveTableViewCell.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import UIKit

class ObjectiveTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var objective_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
