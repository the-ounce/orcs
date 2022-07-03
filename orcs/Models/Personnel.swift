//
//  Personnel.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 03.07.2022.
//

import Foundation

struct Personnel {
    let amount: Int
    let day: Int
    
    var stringAmount: String {
        return String("~\(amount)")
    }
    
    var stringDay: String {
        return String(day)
    }
}
