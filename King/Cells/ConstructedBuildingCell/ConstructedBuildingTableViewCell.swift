//
//  ConstructedBuildingTableViewCell.swift
//  King
//
//  Created by 1111 on 31.07.21.
//

import UIKit

class ConstructedBuildingTableViewCell: UITableViewCell {
    @IBOutlet weak var isUsedLabel: UILabel!
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var population: PopulationView!
    @IBOutlet weak var produces: ResourcesView!
    var isUsed: Bool = false
    var constructedBuilding: ConstructedBuilding?
    var building: Building?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ building: Building){
        self.building = building
        self.isUsedLabel.layer.cornerRadius = 5
        buildingName.text = building.buildingName
        feelProducts()
    }
    
    func configureCell(_ constructedBuilding: ConstructedBuilding){
        constructedBuilding.delegate = self
        isUsed = constructedBuilding.used
        configureCell(constructedBuilding.building)
        useBuilding(constructedBuilding.used)
    }
    
    func feelPersons(){
        guard let building = building else {return}
        if isUsed {
            population.farmers.label.text = "\(building.buildingPersons.farmers)/\(building.buildingPersons.farmers)"
            population.scientists.label.text = "\(building.buildingPersons.scientists)/\(building.buildingPersons.scientists)"
            population.soldiers.label.text = "\(building.buildingPersons.solders)/\(building.buildingPersons.solders)"
        } else {
            population.farmers.label.text = "0/\(building.buildingPersons.farmers)"
            population.scientists.label.text = "0/\(building.buildingPersons.scientists)"
            population.soldiers.label.text = "0/\(building.buildingPersons.solders)"
        }
    }
    
    func feelProducts(){
        guard let building = building else {return}
        produces.gold.label.text = String(building.buildingProduces.gold)
        produces.food.label.text = String(building.buildingProduces.food)
        produces.force.label.text = String(building.buildingProduces.force)
        produces.scince.label.text = String(building.buildingProduces.science)
    }
}

extension ConstructedBuildingTableViewCell: BuildingUsedProtocol{
    func useBuilding(_ used: Bool) {
        self.isUsed = used
        if used {
            isUsedLabel.text = "Здание заселено"
            isUsedLabel.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            feelPersons()
        } else {
            isUsedLabel.text = "Здание простаивает"
            isUsedLabel.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
            feelPersons()
        }
        self.reloadInputViews()
    }
}
