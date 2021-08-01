//
//  Population.swift
//  King
//
//  Created by 1111 on 29.07.21.
//

import Foundation

class Population {
    static let shared = Population()
    var farmers = Farmer(count: 3)
    var scientists = Scientist(count: 1)
    var soldiers = Soldier(count: 1)
    private init(){
        CurrentDate.shared.appendListener(self)
    }
}

extension Population{
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
                Population.shared.soldiers.count += 1
                print("soldier birth")
                return
            }
            if random>0,random<4 {
                print("scientist birth")
                Population.shared.scientists.count += 1
                return
            }
            print("farmer birth")
            Population.shared.farmers.count += 1
        }
    }
    
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
    
    func birthNewPersons(){
        let currentDate = CurrentDate.shared
        if currentDate.dateInt.isMultiple(of: farmers.fertility) {
            Population.shared.description()
            print(farmers.count/2)
            for _ in 1...(farmers.count/2) {
                farmers.birth()
            }
        }
    }
    
    func description(){
        print("farmers: \(farmers.busy)/\(farmers.count); soldiers: \(soldiers.busy)/\(soldiers.count); scientists: \(scientists.busy)/\(scientists.count)")
    }
    
}

extension Population:ChangeDateProtocol {
    func dateChanged(date: Int) {
        birthNewPersons()
    }
    
    
}
