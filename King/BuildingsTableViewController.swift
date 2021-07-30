//
//  BuildingsTableViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class BuildingsTableViewController: UITableViewController {

    var buildings = ConstructedBuildings.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BuildingTableViewCell", bundle: nil), forCellReuseIdentifier: "BuildingTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return buildings.buildings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuildingTableViewCell", for: indexPath) as? BuildingTableViewCell
        cell?.configureCell(buildings.buildings[indexPath.row].building)
        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            var useBuilding = UIAction(title: "Заселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                self.useBuilding(indexPath.row)
            }
            if self.buildings.buildings[indexPath.row].used {
                useBuilding = UIAction(title: "Расселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                    self.presentAlertWithTitle(title: "Расселить здание?", message: "Вы уверены, что хотите расселить это здание?", options: "Нет", "Да") { (option) in
                        switch(option) {
                            case 1:
                                self.buildings.buildings[indexPath.row].notUse()
                                self.tableView.reloadData()
                                break
                            default:
                                break
                        }
                    }                }
            }
            let destroyBuilding = UIAction(title: "Снести здание", image: UIImage(systemName: "trash"), attributes: [.destructive]) { _ in
                print("Здание \(self.buildings.buildings[indexPath.row].building.buildingName) снесено")
                self.presentAlertWithTitle(title: "Снести здание?", message: "Вы уверены, что хотите снести это здание?", options: "Нет", "Да") { (option) in
                    switch(option) {
                        case 1:
                            self.buildings.destroy(index: indexPath.row)
                            self.tableView.reloadData()
                            break
                        default:
                            break
                    }
                }

            }
            return UIMenu(title: "", children: [useBuilding,destroyBuilding])
        }
        
        return contextMenu
    }
    
    func useBuilding(_ index: Int){
        let population = Population.shared
        if buildings.buildings[index].checkToUse(){
            self.presentAlertWithTitle(title: "Заселить здание?", message: "Вы уверены, что хотите построить это здание?", options: "Нет", "Да") { (option) in
                switch(option) {
                    case 1:
                        self.buildings.buildings[index].use()
                        self.tableView.reloadData()
                        break
                    default:
                        break
                }
            }
        } else {
            self.presentAlertWithTitle(title: "Недостаточно людей для заселения постройки", message: "", options: "Ок"){_ in }
        }
    }
}
