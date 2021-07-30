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

