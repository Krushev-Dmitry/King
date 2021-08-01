//
//  Farmers.swift
//  King
//
//  Created by 1111 on 1.08.21.
//

import UIKit

class Farmer: Person {
    let fertility = 5
    
    init() {
        super .init(food: 2)
    }
    
    init(count: Int) {
        super .init(food: 2)
        self.count = count
    }
    
    required init(from decoder: Decoder) throws {
        super .init(food: 2)
    }
    
    func birth(){
        let random = Int.random(in: 0..<10)
        if random == 0 {
            print("soldier birth")
            Population.shared.changePopulation(soldiers: 1)
            return
        }
        if random>0,random<4 {
            print("scientist birth")
            Population.shared.changePopulation(scientists: 1)
            return
        }
        print("farmer birth")
        Population.shared.changePopulation(farmers: 1)
    }
}
