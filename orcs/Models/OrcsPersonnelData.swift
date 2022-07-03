//
//  OrcsPersonnelData.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.
//

import Foundation

struct OrcsPersonnelData: Decodable {
    
    var info: [PersonnelData]
}

struct PersonnelData: Decodable {
    
    var date: String
    var day: Int
    
    var personnel: Int
    var POW: Int
}

//MARK: - JSON Example

/*
    "date": "2022-05-26",
    "day": 92,
    "personnel": 29600,
    "personnel*": "about",
    "POW": 498
*/
