//
//  CardView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 03/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit
// MARK: -  create card view to make Radius
class CardView: UIView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerrRadius
    }
}
// MARK: -  Create Card Image View To Make Radius
class CardUiImage: UIImageView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerrRadius
        
    }
}
// MARK: -  Create Card Effect View To Make Radius
class CardEffectView : UIVisualEffectView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerrRadius
        
    }
}
// MARK: -  Create Card View UI SearchBar To Make Radius
class CardViewUISearchBar: UISearchBar {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerrRadius
    }
    
}
