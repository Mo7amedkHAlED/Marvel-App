//
//  SearchTableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
import RealmSwift
import Kingfisher

// MARK: - Create Protocol To send Button Action
protocol FavoritesView {
    func didTappedFavoriteButton(_ row:Int)
}

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Vars
    var row: Int?
    var delegate: FavoritesView?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners()
        
    }
    // MARK: - Make Round Corners
    func roundCorners() {
        searchImage.clipsToBounds = true
        searchImage.roundCorners(.bottomLeft, radius: 15)
        searchImage.roundCorners(.topLeft, radius: 15)
    }
    // MARK: - Make Configure Cell
    func configureCell(_ favorite:CaractersModel) {
        let imagePath = "\(favorite.caractersImagePath).jpg"
        searchImage.kf.setImage(with: URL(string: "\(imagePath)"))
        searchLabel.text = favorite.caractersName
        favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        
    }
    // MARK: - Make Configure Cell
    func configureSearchCell(_ characterData:CharactersListModel) {
        searchLabel.text = characterData.name
        let characterimage = "\(characterData.thumbnail.path).jpg"
        searchImage.kf.setImage(with: URL(string: "\(characterimage)"))
        favoriteButton.isHidden = true
        
    }
    // MARK: - craete Method to observable when click button by delegate
    @IBAction func TappedFavoriteButton(_ sender: UIButton) {
        guard let row = row else { return }
        delegate?.didTappedFavoriteButton(row)
    }
}
