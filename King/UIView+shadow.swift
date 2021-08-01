//
//  UIView+shadow.swift
//  King
//
//  Created by 1111 on 1.08.21.
//

import UIKit

extension UIView {
func addBottomShadow() {
    layer.masksToBounds = false
    layer.shadowRadius = 5
    layer.shadowOpacity = 1
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0 , height: 2)
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
}
}
