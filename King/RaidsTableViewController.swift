//
//  RaidsTableViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class RaidsTableViewController: UITableViewController {
    let raids = Raids.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RaidsTableViewCell", bundle: nil), forCellReuseIdentifier: "RaidsTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raids.raids.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaidsTableViewCell", for: indexPath) as? RaidsTableViewCell
        cell?.configureCell(raids.raids[indexPath.row])

        return cell ?? UITableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        raids.appendListener(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        raids.removeListener(self)
    }
}

extension RaidsTableViewController:RaidsProtocol{
    func raidIsOver(_ raid: Raid) {
        tableView.reloadData()
    }
}
