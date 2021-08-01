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
    let detailView = DetailView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BuildingTableViewCell", bundle: nil), forCellReuseIdentifier: "BuildingTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Resources.shared.appendListener(self)
        detailView.startListenProtocols()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return detailView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
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
        guard let cell = tableView.cellForRow(at: indexPath) as? BuildingTableViewCell else {return nil}
        guard let building = cell.building else {return nil}
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let addNewBuilding = UIAction(title: "Построить здание", image: UIImage(systemName: "plus"), attributes: []) { _ in
                self.addBuilding(building)
            }
            if !building.checkBuildingCost() {
                addNewBuilding.attributes = .disabled
            }
            return UIMenu(title: "", children: [addNewBuilding])
        }
        return contextMenu
    }
    
    func addBuilding(_ building: Building){
        if !building.checkToUse() {
            self.presentAlertWithTitle(title: "Не хватает людей для заселения здания", message: "Все равно построить?", options: "Нет", "Да") { (option) in
                switch(option) {
                    case 1:
                        ConstructedBuildings.shared.addNewBuilding(building, isUsed: false)
                        self.tableView.reloadData()
                        print("построено новое здание \(building.buildingName), но не заселено")
                        break
                    default:
                        break
                }
            }
        } else {
            ConstructedBuildings.shared.addNewBuilding(building, isUsed: true)
            print("построено новое здание \(building.buildingName),и заселено")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        guard let cell = tableView.cellForRow(at: indexPath) as? BuildingTableViewCell else {return}
        if cell.disable {return}
        guard let building = cell.building else {return}
        let alertController = UIAlertController(title: building.buildingName, message: nil, preferredStyle: .actionSheet)

            if building.checkBuildingCost() {
                let constructedBuilding = UIAlertAction(title: "Построить здание", style: .default) { (action) in
                    self.addBuilding(building)
                }
                alertController.addAction(constructedBuilding)
            } else {
                let constructedBuilding = UIAlertAction(title: "Не хватает ресурсов для постройки здания", style: .default)
                alertController.addAction(constructedBuilding)
            }
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func posscibilityToBuild(){
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        Resources.shared.removeListener(self)
        detailView.stopListenProtocols()
    }
}

extension NewBuildingsTableViewController:ResourcesProtocol{
    func resourcesDidChange(scince: Int, force: Int, food: Int, gold: Int) {
        for (index,building) in buildings.enumerated(){
            guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? BuildingTableViewCell else {return}
            let checkToBuild = building.checkBuildingCost()
            if checkToBuild == cell.disable {
                cell.disable = !checkToBuild
                tableView.reloadData()
            }
        }
    }
}
