//
//  SearchTableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var saerchImage: UIImageView!
    
    @IBOutlet weak var searchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
