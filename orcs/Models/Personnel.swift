//
//  Personnel.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 03.07.2022.
//

import Foundation
import UIKit

struct Personnel {
    let amount: Int
    let day: Int
    
    let title = "Особовий склад"
    let backgroundImageName = "coffinsBackground"
    
    var stringAmount: String {
        return String("~\(amount)")
    }
    
    var stringDay: String {
        return String(day)
    }
}
