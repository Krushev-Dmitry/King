//
//  BuildingsTableViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class BuildingsTableViewController: UITableViewController {

    var constructedBuildings = ConstructedBuildings.shared
    let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentDate.shared.appendListener(self)
        tableView.register(UINib(nibName: "ConstructedBuildingTableViewCell", bundle: nil), forCellReuseIdentifier: "ConstructedBuildingTableViewCell")
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
        // #warning Incomplete implementation, return the number of rows
        return constructedBuildings.buildings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConstructedBuildingTableViewCell", for: indexPath) as? ConstructedBuildingTableViewCell
        cell?.configureCell(constructedBuildings.buildings[indexPath.row])

        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            var useBuilding = UIAction(title: "Заселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                self.constructedBuildings.buildings[indexPath.row].use()
            }
            if !self.constructedBuildings.buildings[indexPath.row].building.checkToUse(){
                useBuilding.attributes = .disabled
            }
            if self.constructedBuildings.buildings[indexPath.row].used {
                useBuilding = UIAction(title: "Расселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                    self.presentAlertWithTitle(title: "Расселить здание?", message: "Вы уверены, что хотите расселить это здание?", options: "Нет", "Да") { (option) in
                        switch(option) {
                            case 1:
                                self.constructedBuildings.buildings[indexPath.row].notUse()
                                break
                            default:
                                break
                        }
                    }
                }
            }
            let destroyBuilding = UIAction(title: "Снести здание", image: UIImage(systemName: "trash"), attributes: [.destructive]) { _ in
                print("Здание \(self.constructedBuildings.buildings[indexPath.row].building.buildingName) снесено")
                self.presentAlertWithTitle(title: "Снести здание?", message: "Вы уверены, что хотите снести это здание?", options: "Нет", "Да") { (option) in
                    switch(option) {
                        case 1:
                            self.constructedBuildings.destroy(index: indexPath.row)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        CurrentDate.shared.removeListener(self)
        CurrentDate.shared.removeListener(detailView)
    }
}

extension BuildingsTableViewController: ChangeDateProtocol {
    func dateChanged(date: Int) {

    }
}
