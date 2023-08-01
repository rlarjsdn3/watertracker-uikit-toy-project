//
//  ViewController.swift
//  WaterTracker
//
//  Created by 김건우 on 8/1/23.
//

import UIKit

class ViewController: UIViewController {

    let waterView = WaterView()
    
    override func loadView() {
        self.view = waterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

