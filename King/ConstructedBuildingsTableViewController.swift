//
//  BuildingsTableViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class ConstructedBuildingsTableViewController: UITableViewController {

    var constructedBuildings = ConstructedBuildings.shared
    let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ConstructedBuildingTableViewCell", bundle: nil), forCellReuseIdentifier: "ConstructedBuildingTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
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
        // #warning Incomplete implementation, return the number of rows
        if constructedBuildings.constructedBuildings.isEmpty{
            return 1
        } else {
        return constructedBuildings.constructedBuildings.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "Вы еще не построили ни одного здания"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: UILabel().font.fontName, size: 22)
        cell.detailTextLabel?.text = "Постройте новое здание нажав наа ''+'' в правом верхнем углу"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = UIFont(name: UILabel().font.fontName, size: 18)
        cell.detailTextLabel?.textColor = .darkGray
        
        if !constructedBuildings.constructedBuildings.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConstructedBuildingTableViewCell", for: indexPath) as? ConstructedBuildingTableViewCell
            cell?.configureCell(constructedBuildings.constructedBuildings[indexPath.row])
            return cell ?? UITableViewCell()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            var useBuilding = UIAction(title: "Заселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                self.constructedBuildings.constructedBuildings[indexPath.row].use()
            }
            if !self.constructedBuildings.constructedBuildings[indexPath.row].building.checkToUse(){
                useBuilding.attributes = .disabled
            }
            if self.constructedBuildings.constructedBuildings[indexPath.row].used {
                useBuilding = UIAction(title: "Расселить здание", image: UIImage(systemName: ""), attributes: []) { _ in
                    self.presentAlertWithTitle(title: "Расселить здание?", message: "Вы уверены, что хотите расселить это здание?", options: "Нет", "Да") { (option) in
                        switch(option) {
                            case 1:
                                self.constructedBuildings.constructedBuildings[indexPath.row].notUse()
                                break
                            default:
                                break
                        }
                    }
                }
            }
            let destroyBuilding = UIAction(title: "Снести здание", image: UIImage(systemName: "trash"), attributes: [.destructive]) { _ in
                print("Здание \(self.constructedBuildings.constructedBuildings[indexPath.row].building.buildingName) снесено")
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        guard let cell = tableView.cellForRow(at: indexPath) as? ConstructedBuildingTableViewCell else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newBuildingsTableViewController = storyBoard.instantiateViewController(withIdentifier: "NewBuildingsTableViewController") as! NewBuildingsTableViewController
            navigationController?.show(newBuildingsTableViewController, sender: self)
            return}
        guard let constructedBuilding = cell.constructedBuilding else {return}
        let building = constructedBuilding.building
        let alertController = UIAlertController(title: building.buildingName, message: "Какие действия хотите провести с этим зданием?", preferredStyle: .actionSheet)

        if !constructedBuilding.used {
            if building.checkToUse() {
                let useBuilding = UIAlertAction(title: "Заселить здание", style: .default) { (action) in
                    self.constructedBuildings.constructedBuildings[indexPath.row].use()
                }
                alertController.addAction(useBuilding)
            } else {
                let useBuilding = UIAlertAction(title: "Не хватает людей для заселения здания", style: .cancel)
                alertController.addAction(useBuilding)
            }
        } else {
            let useBuilding = UIAlertAction(title: "Расселить здание", style: .default) { (action) in
                self.presentAlertWithTitle(title: "Расселить здание?", message: "Вы уверены, что хотите расселить это здание?", options: "Нет", "Да") { (option) in
                    switch(option) {
                        case 1:
                            self.constructedBuildings.constructedBuildings[indexPath.row].notUse()
                            break
                        default:
                            break
                    }
                }
            }
            alertController.addAction(useBuilding)
        }
        let destroyBuilding = UIAlertAction(title: "Снести здание", style: .destructive) { (action) in
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
        alertController.addAction(destroyBuilding)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        detailView.stopListenProtocols()
    }
}

