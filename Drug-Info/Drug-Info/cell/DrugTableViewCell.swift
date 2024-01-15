//
//  DrugTableViewCell.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

import UIKit

class DrugTableViewCell: UITableViewCell {
    
    static let identifier = "DrugTableViewCell"
    
    @IBOutlet weak var drugImage: UIImageView!
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var company: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
