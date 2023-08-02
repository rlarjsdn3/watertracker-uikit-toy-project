//
//  ViewController.swift
//  WaterTracker
//
//  Created by 김건우 on 8/1/23.
//

import UIKit

final class ViewController: UIViewController {

    let waterView = WaterView()
    
    let waterManager = WaterDataManager()
    
    override func loadView() {
        self.view = waterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
    }
    
    override func viewDidLayoutSubviews() {
        updateView()
        
        // NOTE - 위 메소드를 viewDidLoad() 내에 호출하면 뷰(view)의 전체 높이를 제대로 가져오지 못한다.
        //      - 왜냐하면, viewDidLoad() 메서드는 뷰가 메모리에 로드된 직 후에 호출되는데, 이 시점에는 뷰의 크기가 아직 정해지지 않을 수 있다.
    }

    func setupTarget() {
        waterView.glassWaterButton.addTarget(self, action: #selector(glassButtonPressed), for: .touchUpInside)
        waterView.bottleWaterButton.addTarget(self, action: #selector(bottleButtonPressed), for: .touchUpInside)
        waterView.flaskWaterButton.addTarget(self, action: #selector(flaskButtonPressed), for: .touchUpInside)
    }
    
    func updateView() {
        updateProgressView()
        updateDescriptionLabel()
    }
    
    func updateProgressView() {
        let viewTotalHeight = self.view.frame.size.height
        let waterIntakeGoalPerDay = waterManager.getWaterIntakeGoalPerDay()
        let todayWaterIntakeAmount = waterManager.getTodayWaterIntake()
        
        let progressRatio = CGFloat(todayWaterIntakeAmount) / CGFloat(waterIntakeGoalPerDay)
        let progressValue = progressRatio * viewTotalHeight
        
        self.waterView.waterProgressViewHeightConstraint.constant = progressValue
        UIViewPropertyAnimator.init(duration: 0.5, dampingRatio: 0.75) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func updateDescriptionLabel() {
        let waterIntakeGoalPerDay = waterManager.getWaterIntakeGoalPerDay()
        let todayWaterIntakeAmount = waterManager.getTodayWaterIntake()
        
        self.waterView.descriptionLabel.text = "하루 목표 \(waterIntakeGoalPerDay)ml 중 \(todayWaterIntakeAmount)ml를 마셨습니다."
    }
    
    @objc func glassButtonPressed() {
        waterManager.setTodayWaterIntake(100)
        updateView()
    }
    
    @objc func bottleButtonPressed() {
        
    }
    
    @objc func flaskButtonPressed() {
        waterManager.reset()
        updateView()
    }
}

