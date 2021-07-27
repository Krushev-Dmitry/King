//
//  ResourceView.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ResourceView: UIView {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
