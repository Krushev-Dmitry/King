//
//  Resources.swift
//  King
//
//  Created by 1111 on 29.07.21.
//

import Foundation

protocol ResourcesProtocol: AnyObject {
    func resourcesDidChange(scince: Int, force: Int, food: Int, gold: Int)
}

class Resources {
    var scince: Int = 0
    var force: Int = 0
    var food: Int = 100
    var gold: Int = 150
    let collectionFromBuildingsTimer = 2
    
    var listeners: [ResourcesProtocol]?

    static let shared = Resources()
    private init(){
        CurrentDate.shared.appendListener(self)
    }
    
    func appendListener(_ listener: ResourcesProtocol){
        print("Add new listener to current date delegate")
        print(listener)
        guard let listeners = listeners else {
            self.listeners = [listener]
            return
        }
        if listeners.filter({$0 === listener}).isEmpty{
            self.listeners = (self.listeners ?? []) + [listener]
        }
    }
    
    func removeListener(_ listener: ResourcesProtocol) {
        print("Remove listener from current date delegate")
        print(listener)
        guard let listeners = listeners else {return}
        for (index, element) in listeners.enumerated(){
            if element === listener {
                self.listeners?.remove(at: index)
                break
            }
        }
    }
    
    func changeResources(scince: Int = 0, force: Int = 0, food: Int = 0, gold: Int = 0){
        self.scince += scince
        self.force += force
        self.food += food
        self.gold += gold
        listeners?.forEach({$0.resourcesDidChange(scince: scince, force: force, food: food, gold: gold)})
    }
    
    func collectResourcesFromBuildings(_ currentDate: Int){
        let buildings = ConstructedBuildings.shared.constructedBuildings
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
        food -= population.farmers.count * (population.farmers.eatFood ?? 0)
        food -= population.scientists.count * (population.scientists.eatFood ?? 0)
        gold -= population.soldiers.count * (population.soldiers.spendGold ?? 0)
        food -= population.soldiers.count * (population.soldiers.eatFood ?? 0)
    }

    func description(){
        print("scince: \(scince); force: \(force); food: \(food); gold: \(gold)")
    }
    
}

extension Resources: ChangeDateProtocol{
    func dateChanged(date: Int) {
        collectResourcesFromBuildings(date)
        populationSpentResources()
        changeResources()
    }
}
