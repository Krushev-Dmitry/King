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
    
    static let shared = Resources()
    private init(){}
    
    func takeResources(_ collectedResources: BuildingProduces){
        food += collectedResources.food
        gold += collectedResources.gold
    }
    
    func beginUse(_ collectedResources: BuildingProduces){
        scince += collectedResources.science
        force += collectedResources.force
    }
    func stopUse(_ collectedResources: BuildingProduces){
        scince -= collectedResources.science
        force -= collectedResources.force
    }
    func description(){
        print("scince: \(scince); force: \(force); food: \(food); gold: \(gold)")
    }
}
