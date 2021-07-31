//
//  Resources.swift
//  King
//
//  Created by 1111 on 29.07.21.
//

import Foundation

class Resources {
    var scince: Int = 0
    var force: Int = 0
    var food: Int = 100
    var gold: Int = 150
    let collectionFromBuildingsTimer = 2

    static let shared = Resources()
    private init(){
        CurrentDate.shared.appendDelegate(self)
    }
    
    func collectResourcesFromBuildings(_ currentDate: Int){
        let buildings = ConstructedBuildings.shared.buildings
        for building in buildings{
            if building.used {
                let timeOfUsingBuildng = currentDate - building.dateWhenBeginBuildingUsed
                if timeOfUsingBuildng.isMultiple(of: collectionFromBuildingsTimer) {
                    let collectedResources = building.building.buildingProduces
                    food += collectedResources.food
                    gold += collectedResources.gold
                }
            }
        }
    }
    
    func populationSpentResources(){
        let population = Population.shared
        food -= population.farmers.count * (population.farmers.food ?? 0)
        food -= population.scientists.count * (population.scientists.food ?? 0)
        gold -= population.soldiers.count * (population.soldiers.gold ?? 0)
        food -= population.soldiers.count * (population.soldiers.food ?? 0)
    }

    func description(){
        print("scince: \(scince); force: \(force); food: \(food); gold: \(gold)")
    }
    
}

extension Resources: ChangeDateProtocol{
    func dateChanged(date: Int) {
        collectResourcesFromBuildings(date)
        populationSpentResources()
        description()
    }
}
