//
//  Equipment.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 02.07.2022.
//

import Foundation
import UIKit

struct Equipment {
    let title: String
    let amount: Int?
    let image: String
    
    var stringAmount: String {
        return String(amount!)
    }

}

