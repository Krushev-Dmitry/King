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
        buildings.remove(at: index)
    }
}
