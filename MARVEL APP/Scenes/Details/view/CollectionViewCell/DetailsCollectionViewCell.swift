//
//  DetailsCollectionViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - OutLets
    //
    @IBOutlet weak var charcterLabel: UILabel!
    @IBOutlet weak var charcterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    // MARK: - Make Configure Cell
    func configureCell(collectionData: ResultData){
        charcterLabel.text = collectionData.title
        let characterimage = "\(collectionData.thumbnail.path).jpg"
        charcterImage.kf.setImage(with: URL(string: "\(characterimage)"))
    }
}
