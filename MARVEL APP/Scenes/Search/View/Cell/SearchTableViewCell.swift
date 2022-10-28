//
//  SearchTableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    //
    @IBOutlet weak var saerchImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    
    // MARK: - Life Cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saerchImage.layer.cornerRadius = 15
        saerchImage.clipsToBounds = true
        saerchImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
}
