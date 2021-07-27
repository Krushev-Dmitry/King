//
//  ViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resourcesView : ResourcesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(resourcesView)
        // Do any additional setup after loading the view.
    }


}

