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
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var characterName: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // TODO: - Refactor this to be an extension method on all UIViews and pass the desired corners you want to round
        // like: func roundCorners(corners: CACornerMask) {...}
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}

