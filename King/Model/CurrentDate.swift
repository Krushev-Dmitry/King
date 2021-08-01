//
//  Date.swift
//  King
//
//  Created by 1111 on 30.07.21.
//

import UIKit
protocol ChangeDateProtocol: class {
    func dateChanged(date: Int)
}
class CurrentDate{
    var dateInt: Int = 1
    var listeners: [ChangeDateProtocol]?
    
    static let shared = CurrentDate()

    private init(){
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            self.dateInt += 1
            self.listeners?.forEach({ element in
                element.dateChanged(date: self.dateInt)
            })
        }
    }
    
    func appendListener(_ listener: ChangeDateProtocol){
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
    
    func removeListener(_ listener: ChangeDateProtocol) {
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
