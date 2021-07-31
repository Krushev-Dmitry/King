//
//  ViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var population: PopulationView!
    @IBOutlet weak var resourcesView : ResourcesView!
    @IBOutlet weak var dateLabel: UILabel!
//    var viewInsideNavBar: UIView
    let farmers = Population.shared.farmers
    let scientists = Population.shared.scientists
    let soldiers = Population.shared.soldiers
    
    var resources = Resources.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentDate.shared.appendDelegate(self)
        fillPopulationData()
        fillResourcesData()
//        viewInsideNavBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
//        navigationController?.navigationBar.addSubview(viewInsideNavBar)


//        detailView.translatesAutoresizingMaskIntoConstraints = true
//        navigationController?.navigationBar.addSubview(detailView)
//        detailView.topAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor).isActive = true
        let height: CGFloat = 200 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)

        navigationController?.inputView?.addSubview(detailView)
//        navigationController?.navigationItem.titleView?.addSubview(detailView)
        
        
//        let timer3 = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
//            DispatchQueue.main.async {
//                self?.updateDate()
//
//            }
//        }
    }
    
    func fillPopulationData(){
        population.farmers.label.text =  "\(farmers.busy)/\(farmers.count)"
        population.scientists.label.text = "\(scientists.busy)/\(scientists.count)"
        population.soldiers.label.text = "\(soldiers.busy)/\(soldiers.count)"
    }
    func fillResourcesData() {
        resourcesView.scince.label.text = String(resources.scince)
        resourcesView.force.label.text = String(resources.force)
        resourcesView.food.label.text = String(resources.food)
        resourcesView.gold.label.text = String(resources.gold)
    }
}


extension ViewController: ChangeDateProtocol{
    func dateChanged(date: Int) {
        let currentDate = CurrentDate.shared
        dateLabel.text = String(currentDate.dateInt)
        fillPopulationData()
        fillResourcesData()
    }
}
