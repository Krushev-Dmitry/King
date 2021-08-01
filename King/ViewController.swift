//
//  ViewController.swift
//  King
//
//  Created by 1111 on 27.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailView: DetailView!
    var resources = Resources.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        CurrentDate.shared.removeListener(detailView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
}

