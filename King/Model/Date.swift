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
    var delegates: [ChangeDateProtocol]?
    
    static let shared = CurrentDate()

    private init(){
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            self.dateInt += 1
            self.delegates?.forEach({ element in
                element.dateChanged(date: self.dateInt)
            })
        }
    }
    
    func appendDelegate(_ delegate: ChangeDateProtocol){
        guard let delegates = delegates else {
            self.delegates = [delegate]
            return
        }
        if delegates.filter({$0 === delegate}).isEmpty{
            self.delegates = (self.delegates ?? []) + [delegate]
        }
    }
    
    func removeDelegate(_ delegate: ChangeDateProtocol) {
        guard let delegates = delegates else {return}
        for (index, element) in delegates.enumerated(){
            if element === delegate {
                self.delegates?.remove(at: index)
                break
            }
        }
    }
    
    
}
