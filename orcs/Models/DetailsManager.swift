//
//  DetailsText.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 04.07.2022.
//

import Foundation

struct DetailsManager {
    
    // For UI display
    var nameOfSubject: String?
    var numberOfLosses: String?
    var subjectImage: String?
    
    // +2 because [0] = 2 day of the invasion
    var dayOfInvasion: String = String(OrcsManager().chosenDay + 2)

    
    var textEquipmentTemplate: String  {
        return
        
"""
Станом на \(dayOfInvasion)-й день повномасштабного вторгнення, \
Збройними Силами України було знищено велику кількість техніки \
російських окупантів, у цьому ж числі \(nameOfSubject!): приблизно \
\(numberOfLosses!) од.

\(equipmentDetails)

Бий окупанта! Разом переможемо! Наша сила ‒ в правді!
"""
        
    }
    
    var equipmentDetails: String {
        switch nameOfSubject {
        case "Літаки": return
"""
Літачок
"""
        case "Гелікоптери": return
"""

"""
        case "Танки": return
"""

"""
        case "БТР": return
"""

"""
        case "Польова артилерія": return
"""

"""
        case "РСЗВ": return
"""

"""
        case "Дрони": return
"""

"""
        case "Кораблі": return
"""

"""
        case "ББМ": return
"""

"""
        case "Цистерни з ППМ": return
"""

"""
        case "Засоби ППО": return
"""

"""
        case "Спецтехніка": return
"""

"""
        case "Установки ОТРК": return
"""

"""
        case "Автотехніка": return
"""

"""
        case "Крилаті Ракети": return
"""

"""
        default: return "Якась неіснуюча техніка"
        }
    }
    
    
    
    func getDetailsText() -> String {
        return textEquipmentTemplate
    }
    
}
