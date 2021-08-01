//
//  Raids.swift
//  King
//
//  Created by 1111 on 1.08.21.
//

import UIKit

protocol RaidsProtocol: AnyObject{
    func raidIsOver(_ raid: Raid)
}

class Raids {
    let raidsInterval = 12
    let chanceForSucsess = 0.6
    var raids = [Raid]()
    var listeners: [RaidsProtocol]?

    static let shared = Raids()
    private init(){
        CurrentDate.shared.appendListener(self)
    }
    
    func raidOn(){
        let resources = Resources.shared
        let chanceOfRaid = 1/(1+exp(-(Double(resources.force)/Double(resources.gold))))
        print(1/(1+exp(-(Double(resources.force)/Double(resources.gold)))))
        let raid: Raid!
        if chanceOfRaid < chanceForSucsess {
            let loot = Loot(gold: resources.gold*30/100,
                            food: resources.food*30/100)
            raid = Raid(dateOfRaid: CurrentDate.shared.dateInt, sucsessOfRaid: true, loot: loot)
            resources.changeResources(food: -loot.food, gold: -loot.gold)
        } else {
            raid = Raid(dateOfRaid: CurrentDate.shared.dateInt)
        }
        listeners?.forEach({$0.raidIsOver(raid)})
        raids += [raid]
        
    }
    
    func appendListener(_ listener: RaidsProtocol){
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
    
    func removeListener(_ listener: RaidsProtocol) {
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
}

extension Raids:ChangeDateProtocol{
    func dateChanged(date: Int) {
        if date.isMultiple(of: raidsInterval){
            self.raidOn()
        }
    }
}



class Raid {
    let dateOfRaid: Int
    let sucsessOfRaid: Bool
    let loot: Loot?
    
    internal init(dateOfRaid: Int, sucsessOfRaid: Bool = false, loot: Loot? = nil) {
        self.dateOfRaid = dateOfRaid
        self.sucsessOfRaid = sucsessOfRaid
        self.loot = loot
    }
}

struct Loot {
    let gold: Int
    let food: Int
}
