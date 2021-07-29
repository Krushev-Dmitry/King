//
//  ConstructedBuildings.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import Foundation

class ConstructedBuildings {
    static let shared = ConstructedBuildings()
    var buildings = [Building]()
    private init(){}
    
    func addBuilding(_ building: Building){
        buildings += [building]
    }
}
