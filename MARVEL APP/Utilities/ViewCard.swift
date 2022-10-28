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

    class CardEffectView : UIVisualEffectView {
        
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
class CardViewUIButton: UIButton {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerrRadius
    }
}
class CardView2: UIButton {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    
    @IBInspectable var topLeft : Bool = false
    @IBInspectable var topRight : Bool = false
    @IBInspectable var bottomLeft : Bool = false
    @IBInspectable var bottomRight : Bool = false
    @IBInspectable var allCorners : Bool = true
     
    override func layoutSubviews() {
        let rectCorners = [
            topLeft ? CACornerMask.layerMinXMinYCorner : nil,
            topRight ? CACornerMask.layerMaxXMinYCorner : nil,
            bottomLeft ? CACornerMask.layerMinXMaxYCorner : nil,
            bottomRight ? CACornerMask.layerMaxXMaxYCorner : nil,
            allCorners ? [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner] : nil
            ].compactMap({ $0 })
        var maskedCorners: CACornerMask = []
        rectCorners.forEach { (mask) in maskedCorners.insert(mask) }

//        clipsToBounds = true
        layer.cornerRadius = cornerrRadius
        layer.maskedCorners = maskedCorners
//        layer.shadowColor = shadowColor?.cgColor
        
       
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerrRadius)
        layer.shadowPath = shadowPath.cgPath
    }
    
}


