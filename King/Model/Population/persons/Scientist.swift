//
//  Scientists.swift
//  King
//
//  Created by 1111 on 1.08.21.
//

import UIKit

class Scientist: Person {
    init() {
        super .init(food: 1)
    }
    
    init(count: Int) {
        super .init(food: 1)
        self.count = count
    }
    
    required init(from decoder: Decoder) throws {
        super .init(food: 1)
    }
}
