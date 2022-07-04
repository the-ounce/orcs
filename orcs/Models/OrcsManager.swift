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
    
    var totalInfoDays = 1
    
    let fullScaleInvasionDate = DateComponents(year: 2022,  month: 2, day: 24)
    var chosenDay: Int = 0
    
    mutating func getData(for components: DateComponents) {
        
        if (components.day != nil), (components.month != nil), (components.year != nil) {
            
            // How many days from the beggining of the invasion till the chosen date
            let invasionDays = Calendar.current.dateComponents([.day], from: fullScaleInvasionDate, to: components).day! - 1
            
            // Number of invasion days = user's chosen (invasion) day
            chosenDay = invasionDays
            
            performDataFetching()
        }
    }
    
    
    mutating func performDataFetching( ) {
        
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
    
    mutating func parseJSON(personnelData orcsPersonnelData: Data,
                   equipmentData orcsEquipmentData: Data) -> (Personnel,[Equipment])? {
        let decoder = JSONDecoder()
        
        do {
            let decodedPersonnelData = try decoder.decode(OrcsPersonnelData.self, from: orcsPersonnelData)
            let decodedEquipmentData = try decoder.decode(OrcsEquipmentData.self, from: orcsEquipmentData)
            
            // Count and set how many days are in Personnel JSON
            totalInfoDays = (decodedPersonnelData.info.count) + 1

            let personnelCardInfo = createPersonnelModel(decodedPersonnelData)
            let equipCardsInfo = createEquipmentModel(decodedEquipmentData)
    
            return (personnelCardInfo, equipCardsInfo)
            
        } catch {
            print("Error: \(error)")
            return nil
        }
        
        
    }
    
    
// MARK: - Create Personnel & Equip Models
    func createPersonnelModel(_ personnelData: OrcsPersonnelData) -> Personnel {
        
        let personnel = personnelData.info[chosenDay].personnel
        let day = personnelData.info[chosenDay].day
        
        let personnelInfo = Personnel(amount: personnel, day: day)
//      let POW = personnelData.info[chosenDay].POW
        
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
            Equipment(title: "Літаки", amount: aircraft, image: "aircraft"),
            Equipment(title: "Гелікоптери", amount: helicopter, image: "helicopter"),
            Equipment(title: "Танки", amount: tank, image: "tank"),
            Equipment(title: "БТР", amount: apc, image: "apc"),
            Equipment(title: "Польова артилерія", amount: fieldArtillery, image: "fieldArtillery"),
            Equipment(title: "РСЗВ", amount: mrl, image: "mrl"),
            Equipment(title: "Дрони", amount: drone, image: "drone"),
            Equipment(title: "Кораблі", amount: navalShip, image: "navalShip"),
            Equipment(title: "ББМ", amount: militaryAuto, image: "militaryAuto"),
            Equipment(title: "Цистерни з ППМ", amount: fuelTank, image: "fuelTank"),
            Equipment(title: "Засоби ППО", amount: antiAircraftWarfare, image: "antiAircraftWarfare"),
            Equipment(title: "Спецтехніка", amount: specialEquipment, image: "specialEquipment"),
            Equipment(title: "Установки ОТРК", amount: mobileSRBMSystem, image: "mobileSRBMSystem"),
            Equipment(title: "Автотехніка", amount: vehiclesAndFuelTanks, image: "vehiclesAndFuelTanks"),
            Equipment(title: "Крилаті Ракети", amount: cruiseMissiles, image: "cruiseMissiles")
        ]
        
        // remove Objects with nil attributes
        equipCardsInfo.removeAll(where: { $0.amount == nil })

        return equipCardsInfo
    }
    
//MARK: - Date-related
    func maximumInfoDate() -> Date {
        let invasionDays: Date = Calendar(identifier: .gregorian).date(from: fullScaleInvasionDate)!
        
        let maximumDate = Calendar.current.date(byAdding: DateComponents(day: totalInfoDays - 1), to: invasionDays)!
        
        return maximumDate
    }
    
    func minimumInfoDate() -> Date {
        let minimumDate: Date = Calendar(identifier: .gregorian).date(from: fullScaleInvasionDate)!
        
        return minimumDate
    }
    
    func minimumInfoDateComponents() -> DateComponents {
        let invasionDays: Date = Calendar(identifier: .gregorian).date(from: fullScaleInvasionDate)!
        
        let minimumDate = Calendar.current.date(byAdding: DateComponents(day: totalInfoDays), to: invasionDays)!
        
        let minimumDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: minimumDate)
        
        return minimumDateComponents
    }
}
