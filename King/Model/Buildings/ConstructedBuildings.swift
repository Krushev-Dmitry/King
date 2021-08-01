//
//  ConstructedBuildings.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import UIKit

class ConstructedBuildings {
    static let shared = ConstructedBuildings()
    var constructedBuildings = [ConstructedBuilding]()
    private init(){}
    
    func destroy(index: Int){
        constructedBuildings[index].notUse()
        constructedBuildings.remove(at: index)
    }
    func addNewBuilding(_ building: Building, isUsed: Bool = false){
        let constructedBuilding = ConstructedBuilding(building, isUsed: isUsed)
        constructedBuildings += [constructedBuilding]
    }

}
