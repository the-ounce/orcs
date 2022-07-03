//
//  OrcsManager.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.
//

import Foundation

protocol OrcsManagerDelegate {
    func didUpdateOrcsLossesInfo(_ orcsLossesInfo: (Personnel, [Equipment]))
    func didFailWithError(error: Error)
}

struct OrcsManager {
    
    var delegate: OrcsManagerDelegate?
    
    var chosenDay: Int = 5
    
    mutating func getData( ) {
        performDataFetching()
        chosenDay += 1
    }
    
    
    func performDataFetching( ) {
        
        guard let urlPathToEquipment = Bundle.main.url(forResource: "russia_losses_equipment", withExtension: "json") else { return }
        
        guard let urlPathToPersonnel = Bundle.main.url(forResource: "russia_losses_personnel", withExtension: "json") else { return }
        
        do {
            let orcsPersonnelData = try Data(contentsOf: urlPathToPersonnel)
            let orcsEquipmentData = try Data(contentsOf: urlPathToEquipment)
            
            let orcs = parseJSON(personnelData: orcsPersonnelData, equipmentData: orcsEquipmentData)
            
            if let safeDataOrcs = orcs {
                delegate?.didUpdateOrcsLossesInfo(safeDataOrcs)
            }
            
            return
            
        } catch {
            print("error: \(error)")
        }
        
        
    }
    
    func parseJSON(personnelData orcsPersonnelData: Data,
                   equipmentData orcsEquipmentData: Data) -> (Personnel,[Equipment])? {
        let decoder = JSONDecoder()
        
        do {
            let decodedPersonnelData = try decoder.decode(OrcsPersonnelData.self, from: orcsPersonnelData)
            let decodedEquipmentData = try decoder.decode(OrcsEquipmentData.self, from: orcsEquipmentData)
            
            let personnelCardInfo = createPersonnelModel(decodedPersonnelData)
            let equipCardsInfo = createEquipmentModel(decodedEquipmentData)
    
            return (personnelCardInfo, equipCardsInfo)
            
        } catch {
            print("Error: \(error)")
            return nil
        }
        
        
    }
    
    
    func createPersonnelModel(_ personnelData: OrcsPersonnelData) -> Personnel {
        let personnel = personnelData.info[chosenDay].personnel
//      let POW = personnelData.info[chosenDay].POW
        
        let personnelInfo = Personnel(amount: personnel)
        
        return personnelInfo
    }
    
    
    func createEquipmentModel(_ equipData: OrcsEquipmentData) -> [Equipment] {
            
        let (aircraft,
             helicopter,
             tank,
             apc,
             fieldArtillery,
             mrl,
             drone,
             navalShip,
             antiAircraftWarfare) = (equipData.info[chosenDay].aircraft,
                                     equipData.info[chosenDay].helicopter,
                                     equipData.info[chosenDay].tank,
                                     equipData.info[chosenDay].apc,
                                     equipData.info[chosenDay].fieldArtillery,
                                     equipData.info[chosenDay].mrl,
                                     equipData.info[chosenDay].drone,
                                     equipData.info[chosenDay].navalShip,
                                     equipData.info[chosenDay].antiAircraftWarfare)
        // Optionals
        let (militaryAuto,
             fuelTank,
             specialEquipment,
             mobileSRBMSystem,
             vehiclesAndFuelTanks,
             cruiseMissiles) = (equipData.info[chosenDay].militaryAuto,
                                equipData.info[chosenDay].fuelTank,
                                equipData.info[chosenDay].specialEquipment,
                                equipData.info[chosenDay].mobileSRBMSystem,
                                equipData.info[chosenDay].vehiclesAndFuelTanks,
                                equipData.info[chosenDay].cruiseMissiles)
        
        var equipCardsInfo: [Equipment] = [
            Equipment(title: "Літаки", amount: aircraft, image: "helicopter"),
            Equipment(title: "Гелікоптери", amount: helicopter, image: "helicopter"),
            Equipment(title: "Танки", amount: tank, image: "helicopter"),
            Equipment(title: "БТР", amount: apc, image: "helicopter"),
            Equipment(title: "Польова артилерія", amount: fieldArtillery, image: "helicopter"),
            Equipment(title: "РСЗВ", amount: mrl, image: "helicopter"),
            Equipment(title: "Дрони", amount: drone, image: "helicopter"),
            Equipment(title: "Кораблі", amount: navalShip, image: "helicopter"),
            Equipment(title: "ББМ", amount: militaryAuto, image: "helicopter"),
            Equipment(title: "Цистерни з ППМ", amount: fuelTank, image: "helicopter"),
            Equipment(title: "Засоби ППО", amount: antiAircraftWarfare, image: "helicopter"),
            Equipment(title: "Спецтехніка", amount: specialEquipment, image: "helicopter"),
            Equipment(title: "Установки ОТРК", amount: mobileSRBMSystem, image: "helicopter"),
            Equipment(title: "Автотехніка", amount: vehiclesAndFuelTanks, image: "helicopter"),
            Equipment(title: "Крилаті Ракети", amount: cruiseMissiles, image: "helicopter")
        ]
        
        // remove Objects with nil attributes
        equipCardsInfo.removeAll(where: { $0.amount == nil })

        return equipCardsInfo
    }
    
}
