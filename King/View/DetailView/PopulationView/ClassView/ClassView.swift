//
//  PopulationView.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

@IBDesignable
class ClassView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "ClassView") else {return}
        image.backgroundColor = .white
        view.frame = self.bounds
        view.backgroundColor = nil
        self.addSubview(view)
        self.backgroundColor = nil

    }
    
    
}
