//
//  PopulationView.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit
@IBDesignable
class PopulationView: UIView {
    @IBOutlet weak var farmers: ClassView!
    @IBOutlet weak var soldiers: ClassView!
    @IBOutlet weak var scientists: ClassView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "PopulationView") else {return}
        farmers.image.image = #imageLiteral(resourceName: "farmer")
        soldiers.image.image = #imageLiteral(resourceName: "solder")
        scientists.image.image = #imageLiteral(resourceName: "scientist")
        scientists.image.backgroundColor = .none
        view.frame = self.bounds
        view.backgroundColor = nil
        self.backgroundColor = nil
        self.addSubview(view)
    }
}
