//
//  ConstructedBuilding.swift
//  King
//
//  Created by 1111 on 30.07.21.
//

import Foundation

class ConstructedBuilding{
    let building: Building
    var used = false
    init(_ building: Building) {
        self.building = building
    }
    
    func checkToUse()->Bool{
        let population = Population.shared
        guard population.farmers.free()>=building.buildingPersons.farmers else {return false}
        guard population.scientists.free()>=building.buildingPersons.scientists else {return false}
        guard population.soldiers.free()>=building.buildingPersons.solders else {return false}
        return true
    }
    func use(){
        let population = Population.shared
        population.farmers.busy += building.buildingPersons.farmers
        population.scientists.busy += building.buildingPersons.scientists
        population.soldiers.busy += building.buildingPersons.solders
        print("Здание заселено и используется \(building.buildingName)")
        used = true
    }
    
    func notUse(){
        let population = Population.shared
        population.farmers.busy -= building.buildingPersons.farmers
        population.scientists.busy -= building.buildingPersons.scientists
        population.soldiers.busy -= building.buildingPersons.solders
        print("Здание расселено и не используется \(building.buildingName)")
        self.used = false
    }
    
}
