//
//  ViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var population: PopulationView!
    @IBOutlet weak var resourcesView : ResourcesView!
    @IBOutlet weak var dateLabel: UILabel!
    var currentDate = CurrentDate.shared
    let farmers = Population.shared.farmers
    let scientists = Population.shared.scientists
    let soldiers = Population.shared.soldiers
    
    var resources = Resources.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = String(currentDate.dateInt)
        fillPopulationData()
        resourceUpdait()
        
        
        let timer3 = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateDate()
            }
        }
        
    }
    
    func fillPopulationData(){
        population.farmers.label.text =  "\(farmers.busy)/\(farmers.count)"
        population.scientists.label.text = "\(scientists.busy)/\(scientists.count)"
        population.soldiers.label.text = "\(soldiers.busy)/\(soldiers.count)"
    }
    func fillResourcesDate() {
        resourcesView.scince.label.text = String(resources.scince)
        resourcesView.force.label.text = String(resources.force)
        resourcesView.food.label.text = String(resources.food)
        resourcesView.gold.label.text = String(resources.gold)
    }
    func resourceUpdait(){
        resources.description()
        resources.gold -= soldiers.count * (soldiers.gold ?? 0)
        resources.food -= farmers.count * (farmers.food ?? 0)
        resources.food -= scientists.count * (scientists.food ?? 0)
        resources.food -= soldiers.count * (soldiers.food ?? 0)
        resources.description()
        fillResourcesDate()
    }
    
    func updateDate(){
        self.currentDate.dateInt += 1
        dateLabel.text = String(currentDate.dateInt)
        if self.currentDate.dateInt.isMultiple(of: farmers.fertility) {
            Population.shared.description()
            print(farmers.count/2)
            for _ in 1...(farmers.count/2) {
                farmers.birth()
            }
            fillPopulationData()
        }

        resourceUpdait()
    }
    
    


}

