//
//  ChallengesTableViewCell.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import UIKit

class ChallengesTableViewCell: UITableViewCell {

    @IBOutlet weak var time_lbl: UILabel!
    @IBOutlet weak var object_lbl: UILabel!
    @IBOutlet weak var challenge_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
