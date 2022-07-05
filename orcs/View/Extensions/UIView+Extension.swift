//
//  UIView+IBInspectable.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 03.07.2022.
//

import Foundation
import UIKit

//@IBDesignable
class RoundUIView: UIView {

    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
                get { return layer.borderWidth }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {  layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor }
        get { return UIColor(cgColor: layer.shadowColor!) }
    }
    
}


