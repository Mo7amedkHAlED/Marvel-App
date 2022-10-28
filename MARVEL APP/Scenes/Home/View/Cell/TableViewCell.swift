//
//  TableViewCell.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Tableimage: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}

