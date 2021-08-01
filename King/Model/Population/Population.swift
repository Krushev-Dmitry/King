//
//  Population.swift
//  King
//
//  Created by 1111 on 29.07.21.
//

import Foundation

protocol PopulationProtocol: AnyObject {
    func populationDidChange(farmers: Farmer, scientists: Scientist, solders: Soldier)
}

class Population {
    static let shared = Population()
    private init(){
        CurrentDate.shared.appendListener(self)
    }
    var farmers = Farmer(count: 20)
    var scientists = Scientist(count: 10)
    var soldiers = Soldier(count: 10)
    
    var listeners: [PopulationProtocol]?
    
    func appendListener(_ listener: PopulationProtocol){
        print("Add new listener to current date delegate")
        print(listener)
        guard let listeners = listeners else {
            self.listeners = [listener]
            return
        }
        if listeners.filter({$0 === listener}).isEmpty{
            self.listeners = (self.listeners ?? []) + [listener]
        }
    }
    
    func removeListener(_ listener: PopulationProtocol) {
        print("Remove listener from current date delegate")
        print(listener)
        guard let listeners = listeners else {return}
        for (index, element) in listeners.enumerated(){
            if element === listener {
                self.listeners?.remove(at: index)
                break
            }
        }
    }
    
    func changePopulation(farmers: Int = 0, scientists: Int = 0, soldiers: Int = 0){
        self.farmers.count += farmers
        self.scientists.count += scientists
        self.soldiers.count += soldiers
        listeners?.forEach({$0.populationDidChange(farmers: self.farmers, scientists: self.scientists, solders: self.soldiers)})
    }
    
    func changeBusyPopulation(busyFarmers: Int = 0, busyScientists: Int = 0, busySoldiers: Int = 0){
        self.farmers.busy += busyFarmers
        self.scientists.busy += busyScientists
        self.soldiers.busy += busySoldiers
        listeners?.forEach({$0.populationDidChange(farmers: farmers, scientists: scientists, solders: soldiers)})
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
