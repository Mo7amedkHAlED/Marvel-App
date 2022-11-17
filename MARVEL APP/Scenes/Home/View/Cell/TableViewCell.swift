//
//  TableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var characterHomeImage: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var characterName: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners()
    }
    func roundCorners() {
        blurView.roundCorners(.bottomLeft, radius: 10)
        blurView.roundCorners(.bottomRight, radius: 10)
        blurView.clipsToBounds = true
    }
    func configureCell(tableData: CharactersListModel) {
        let charactername = tableData.name
        characterName.text = charactername
        let characterimage = "\(tableData.thumbnail.path).jpg"
        characterHomeImage.kf.setImage(with: URL(string: "\(characterimage)"))
    }
}

