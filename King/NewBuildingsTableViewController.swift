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
    let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CurrentDate.shared.appendListener(self)
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
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        CurrentDate.shared.removeListener(self)
        CurrentDate.shared.removeListener(detailView)
    }
}

extension NewBuildingsTableViewController: ChangeDateProtocol {
    func dateChanged(date: Int) {

    }
}
