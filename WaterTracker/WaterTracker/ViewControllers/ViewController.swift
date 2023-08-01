//
//  ViewController.swift
//  WaterTracker
//
//  Created by 김건우 on 8/1/23.
//

import UIKit

class ViewController: UIViewController {

    let waterView = WaterView()
    
    let waterManager = WaterDataManager()
    
    override func loadView() {
        self.view = waterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupTarget() {
        waterView.glassWaterButton.addTarget(self, action: #selector(glassButtonPressed), for: .touchUpInside)
        waterView.bottleWaterButton.addTarget(self, action: #selector(bottleButtonPressed), for: .touchUpInside)
        waterView.flaskWaterButton.addTarget(self, action: #selector(flaskButtonPressed), for: .touchUpInside)
    }
    
    @objc func glassButtonPressed() {
        
    }
    
    @objc func bottleButtonPressed() {
        
    }
    
    @objc func flaskButtonPressed() {
        
    }
}

