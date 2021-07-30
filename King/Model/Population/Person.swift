//
//  Person.swift
//  King
//
//  Created by 1111 on 29.07.21.
//

import Foundation

class Person: Codable{
    let food: Int?
    let gold: Int?
    var count: Int = 0
    var busy = 0
    init(food: Int = 0, gold: Int = 0) {
        self.food = food
        self.gold = gold
    }
    func free()->Int{
        return count-busy
    }
}
