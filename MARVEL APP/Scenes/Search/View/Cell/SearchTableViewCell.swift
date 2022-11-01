//
//  SearchTableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

protocol FavoriteButton{
    func didTappedFavoriteButton(_ row:Int)
}
class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    //
    @IBOutlet weak var saerchImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    // MARK: - Vars
    var row: Int?
    var delegate: FavoriteButton?
//    var didTappedFavroiteButtonClosure: ((_ row:Int)->Void)?
    // MARK: - Life Cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saerchImage.layer.cornerRadius = 15
        saerchImage.clipsToBounds = true
        saerchImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let row = row else {return}
        delegate?.didTappedFavoriteButton(row)
    }
}
