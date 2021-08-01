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
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.941, green: 0.925, blue: 0.937, alpha: 1)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        print(1/(1+exp(-(Double(resources.force)/Double(resources.gold)))))
        detailView.stopListenProtocols()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        detailView.startListenProtocols()
    }
}

