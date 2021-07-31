//
//  Buildings.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import Foundation

struct Building:Codable {
    let buildingName: String
    let buildingCost: BuildingCost
    let buildingPersons: BuildingPersons
    let buildingProduces: BuildingProduces
    
    func checkBuildingCost()->Bool{
        let resources = Resources.shared
        if buildingCost.gold<=resources.gold, buildingCost.scince <= resources.scince {
        return true
        }
        return false
    }
    func checkToUse()->Bool{
        let population = Population.shared
        guard population.farmers.free() >= buildingPersons.farmers else {return false}
        guard population.scientists.free() >= buildingPersons.scientists else {return false}
        guard population.soldiers.free() >= buildingPersons.solders else {return false}
        return true
    }
}

struct BuildingCost:Codable {
    let gold: Int
    let scince: Int
}

struct BuildingPersons:Codable {
    let farmers: Int
    let scientists: Int
    let solders: Int
}
struct BuildingProduces:Codable {
    let science: Int
    let force: Int
    let gold: Int
    let food: Int
}

