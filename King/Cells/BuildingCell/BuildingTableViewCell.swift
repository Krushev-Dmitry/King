//
//  BuildingTableViewCell.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class BuildingTableViewCell: UITableViewCell {
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var gold: ResourceView!
    @IBOutlet weak var scince: ResourceView!
    @IBOutlet weak var population: PopulationView!
    @IBOutlet weak var produces: ResourcesView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gold.image.image = #imageLiteral(resourceName: "gold")
        scince.image.image = #imageLiteral(resourceName: "science")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ building: Building){
        buildingName.text = building.buildingName
       
        gold.label.text =
            String(building.buildingCost.gold)
        scince.label.text = String(building.buildingCost.scince)


        population.farmers.label.text = String(building.buildingPersons.farmers)
        population.scientists.label.text = String(building.buildingPersons.scientists)
        population.soldiers.label.text = String(building.buildingPersons.solders)
        
        produces.gold.label.text = String(building.buildingProduces.gold)
        produces.food.label.text = String(building.buildingProduces.food)
        produces.force.label.text = String(building.buildingProduces.force)
        produces.scince.label.text = String(building.buildingProduces.science)
    }
    
}
