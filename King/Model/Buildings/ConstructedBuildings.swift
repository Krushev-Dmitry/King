//
//  ConstructedBuildings.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import UIKit

class ConstructedBuildings {
    static let shared = ConstructedBuildings()
    var buildings = [ConstructedBuilding]()
    let collectionTimer = 2
    private init(){}
    
    func destroy(index: Int){
        buildings[index].notUse()
        buildings.remove(at: index)
    }
    func collectResources(_ currentDate: Int){
        for (index, building) in buildings.enumerated(){
            if building.used {
                let timeOfUsingBuildng = currentDate - building.dateWhenBeginBuildingUsed
                if timeOfUsingBuildng.isMultiple(of: collectionTimer) {
                    Resources.shared.takeResources(building.building.buildingProduces)
                }
            }
        }
    }
}
