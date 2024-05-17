//
//  MyDrugCollectionViewCell.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/04/06.
//

import UIKit

class MyDrugCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drugContentView: UIView!
    @IBOutlet weak var drugImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        drugContentView.layer.cornerRadius = 17
        drugImageView.layer.cornerRadius = 15
    }

}
