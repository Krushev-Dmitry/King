//
//  DetailView.swift
//  King
//
//  Created by 1111 on 31.07.21.
//

import UIKit

class DetailView: UIView {
    @IBOutlet weak var populationView: PopulationView!
    @IBOutlet weak var recourcesView: ResourcesView!
    @IBOutlet weak var dateView: UILabel!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "DetailView") else {return}
        view.frame = self.bounds
        view.backgroundColor = UIColor(red: 0.941, green: 0.925, blue: 0.937, alpha: 1)
//        view.backgroundColor = UIColor(cgColor: UIColor.white.withAlphaComponent(0.2).cgColor)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        let currentData = CurrentDate.shared
        dateChanged(date: currentData.dateInt)
         self.addSubview(view)
        self.backgroundColor = .white
        bounceCornerRadiusPersonsImage()
    }
    
    func bounceCornerRadiusPersonsImage(){
        if let person = populationView.farmers {
        person.image.layer.cornerRadius = person.image.bounds.height/2
        person.image.layer.masksToBounds = true
        }
        if let person = populationView.scientists {
        person.image.layer.cornerRadius = person.image.bounds.height/2
        person.image.layer.masksToBounds = true
        }
        if let person = populationView.soldiers {
        person.image.layer.cornerRadius = person.image.bounds.height/2
        person.image.layer.masksToBounds = true
        }
        
    }
    
    func fillPopulationData(){
        let population = Population.shared
        let farmers = population.farmers
        let scientists = population.scientists
        let soldiers = population.soldiers
        populationView.farmers.label.text =  "\(farmers.busy)/\(farmers.count)"
        populationView.scientists.label.text = "\(scientists.busy)/\(scientists.count)"
        populationView.soldiers.label.text = "\(soldiers.busy)/\(soldiers.count)"
    }
    func fillResourcesData() {
        let resources = Resources.shared
        recourcesView.scince.label.text = String(resources.scince)
        recourcesView.force.label.text = String(resources.force)
        recourcesView.food.label.text = String(resources.food)
        recourcesView.gold.label.text = String(resources.gold)
    }
}

extension DetailView: ChangeDateProtocol{
    func dateChanged(date: Int) {
        dateView.text = String(date)
        fillPopulationData()
        fillResourcesData()
    }
}
