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
        let timer3 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            print("sdfsdfdsfg")
        }
    }


}

