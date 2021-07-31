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
    private init(){}
    
    func destroy(index: Int){
        buildings[index].notUse()
        buildings.remove(at: index)
    }
    func addNewBuilding(_ building: Building, isUsed: Bool = false){
        let constructedBuilding = ConstructedBuilding(building, used: isUsed)
        buildings += [constructedBuilding]
    }

}
