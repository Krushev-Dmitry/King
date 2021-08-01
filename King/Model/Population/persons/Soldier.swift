//
//  Soldier.swift
//  King
//
//  Created by 1111 on 1.08.21.
//

import UIKit

class Soldier: Person {
    init() {
        super .init(food: 4, gold: 1)
    }
    
    init(count: Int) {
        super .init(food: 4, gold: 1)
        self.count = count
    }
    
    required init(from decoder: Decoder) throws {
        super .init(food: 4, gold: 1)
    }
}

