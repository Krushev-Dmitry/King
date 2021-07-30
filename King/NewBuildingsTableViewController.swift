//
//  NewBuildingsTableViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class NewBuildingsTableViewController: UITableViewController {

    let buildings = Buildings.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BuildingTableViewCell", bundle: nil), forCellReuseIdentifier: "BuildingTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BuildingTableViewCell", for: indexPath) as? BuildingTableViewCell else {return UITableViewCell()}
        cell.configureCell(buildings[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let addNewBuilding = UIAction(title: "Построить здание", image: UIImage(systemName: "plus"), attributes: []) { _ in
                guard let cell = tableView.cellForRow(at: indexPath) as? BuildingTableViewCell else {return}
                guard let building = cell.building else {return}
                self.addBuilding(building)
            }
            return UIMenu(title: "", children: [addNewBuilding])
        }
        return contextMenu
    }
    
    func addBuilding(_ building: Building){
        if building.checkBuildingCost(){
            self.presentAlertWithTitle(title: "Построить здание?", message: "Вы уверены, что хотите построить это здание", options: "Нет", "Да") { (option) in
                switch(option) {
                    case 1:
                        Resources.shared.gold -= building.buildingCost.gold
                        ConstructedBuildings.shared.buildings += [ConstructedBuilding(building)]
                        print("построено новое здание \(building.buildingName)")
                        break
                    default:
                        break
                }
            }
        } else {
            self.presentAlertWithTitle(title: "Недостаточно ресурсов для постройки", message: "", options: "Ок"){_ in }
        }
    }
}
