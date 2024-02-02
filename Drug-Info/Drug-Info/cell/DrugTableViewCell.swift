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
        
        // 테두리 둥글게 설정
        drugImage.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
