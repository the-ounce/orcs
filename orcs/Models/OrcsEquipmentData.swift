//
//  OrcsData.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.
//

import Foundation

struct OrcsEquipmentData: Decodable {
    
    let info: [LossesInfo]
    
}

struct LossesInfo: Decodable {
    
    var date: String
    var day: Int
    
    var aircraft,
        helicopter,
        tank,
        apc,
        fieldArtillery,
        mrl,
        drone,
        navalShip,
        antiAircraftWarfare: Int
    
    var militaryAuto,
        fuelTank,
        specialEquipment,
        mobileSRBMSystem,
        vehiclesAndFuelTanks,
        cruiseMissiles: Int?
    
}


//MARK: - JSON Example

/*
    "date": "2022-05-16",
     "day": 82,
     "aircraft": 200,
     "helicopter": 165,
     "tank": 1228,
     "APC": 2974,
     "field artillery": 577,
     "MRL": 195,
nil? "military auto": NaN,
nil? "fuel tank": NaN,
     "drone": 427,
     "naval ship": 13,
     "anti-aircraft warfare": 89,
nil? "special equipment": 42,
nil? "mobile SRBM system": NaN,
nil? "vehicles and fuel tanks": 2101,
nil? "cruise missiles": 97
*/
