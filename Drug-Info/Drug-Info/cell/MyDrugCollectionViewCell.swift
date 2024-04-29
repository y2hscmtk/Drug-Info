//
//  MyDrugCollectionViewCell.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/04/06.
//

import UIKit

class MyDrugCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var drugContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderView.layer.cornerRadius = 15
        drugContentView.layer.cornerRadius = 10
    }

}
