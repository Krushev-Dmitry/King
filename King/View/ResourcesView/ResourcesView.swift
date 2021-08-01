//
//  ResourcesView.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class ResourcesView: UIView {
    @IBOutlet weak var scince: ResourceView!
    @IBOutlet weak var force: ResourceView!
    @IBOutlet weak var food: ResourceView!
    @IBOutlet weak var gold: ResourceView!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "ResourcesView") else {return}
        view.frame = self.bounds
        scince.image.image = #imageLiteral(resourceName: "science")
        force.image.image = #imageLiteral(resourceName: "raid")
        food.image.image = #imageLiteral(resourceName: "food")
        gold.image.image = #imageLiteral(resourceName: "gold")
        view.backgroundColor = nil
        self.backgroundColor = nil
        self.addSubview(view)
    }
}
