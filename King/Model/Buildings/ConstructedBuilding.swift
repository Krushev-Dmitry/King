//
//  ConstructedBuilding.swift
//  King
//
//  Created by 1111 on 30.07.21.
//

import Foundation
protocol BuildingUsedProtocol: Any {
    func useBuilding(_ used: Bool)
}

class ConstructedBuilding{
    let building: Building
    var used = false
    var delegate: BuildingUsedProtocol?
    
    var dateWhenBeginBuildingUsed: Int = 0
    
    init(_ building: Building, isUsed: Bool = false) {
        self.building = building
        self.used = isUsed
        Resources.shared.gold -= building.buildingCost.gold
        dateWhenBeginBuildingUsed = CurrentDate.shared.dateInt
        if isUsed {
            self.use()
        }
        delegate?.useBuilding(isUsed)
    }
    
    func use(){
        self.used = true
        print("Здание заселено и используется \(building.buildingName)")
        delegate?.useBuilding(used)
        changeResources()
        changePopulation()
        dateWhenBeginBuildingUsed = CurrentDate.shared.dateInt
    }
    
    func notUse(){
        self.used = false
        print("Здание расселено и не используется \(building.buildingName)")
        delegate?.useBuilding(used)
        changePopulation()
        changeResources()
    }
    
    func changePopulation(){
        let population = Population.shared
        if used {
            population.farmers.busy += building.buildingPersons.farmers
            population.scientists.busy += building.buildingPersons.scientists
            population.soldiers.busy += building.buildingPersons.solders
        } else {
            population.farmers.busy -= building.buildingPersons.farmers
            population.scientists.busy -= building.buildingPersons.scientists
            population.soldiers.busy -= building.buildingPersons.solders
        }
    }
    func changeResources(){
        let resources = Resources.shared
        if used {
            resources.scince += building.buildingProduces.science
            resources.force += building.buildingProduces.force
        } else {
            resources.scince -= building.buildingProduces.science
            resources.force -= building.buildingProduces.force
        }
    }
    
}
