//
//  CardView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 03/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
