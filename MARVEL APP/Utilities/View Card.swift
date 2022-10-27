//
//  CardView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 03/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
     
    override func layoutSubviews() {
  layer.cornerRadius = cornerrRadius
  }
    
}

class CardUiImage: UIImageView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
     
    override func layoutSubviews() {
  layer.cornerRadius = cornerrRadius
  }
    
}

class CardViewUISearchBar: UISearchBar {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
     
    override func layoutSubviews() {
  layer.cornerRadius = cornerrRadius
  }
    
}
