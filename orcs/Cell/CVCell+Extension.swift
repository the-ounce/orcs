//
//  CVCell+Extension.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 03.07.2022.
//

import Foundation
import UIKit

//@IBDesignable
class RoundCollectionViewCell: CollectionViewCell {

    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }

}
