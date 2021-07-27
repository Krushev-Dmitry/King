//
//  ViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resourcesView : ResourcesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(resourcesView)
        let build1 = Building(buildingName: "Казарма",
                              buildingCost: BuildingCost(gold: 500,
                                                         scince: 50),
                              buildingPersons: BuildingPersons(farmers: 0,
                                                               scientists: 0,
                                                               solders: 10),
                              buildingProduces: BuildingProduces(science: 0,
                                                                 force: 50,
                                                                 gold: 0,
                                                                 food: 0))
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode([build1])
        print(String(data: data, encoding: .utf8)!)
    }


}

