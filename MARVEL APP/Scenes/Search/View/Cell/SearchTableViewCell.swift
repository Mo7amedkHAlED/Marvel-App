//
//  SearchTableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
// TODO: Rename this protocol to match the swift protocol naming convension
// MARK: - Create Protocol To send Button Action
protocol FavoriteButton {
    func didTappedFavoriteButton(_ row:Int)
}

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var saerchImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Vars
    var row: Int?
    var delegate: FavoriteButton?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // TODO: - Refactor this to be an extension method on all UIViews and pass the desired corners you want to round
        // like: func roundCorners(corners: CACornerMask) {...}
        saerchImage.layer.cornerRadius = 15
        saerchImage.clipsToBounds = true
        saerchImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    // TODO: - Rename this method
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let row = row else { return }
        delegate?.didTappedFavoriteButton(row)
    }
}
