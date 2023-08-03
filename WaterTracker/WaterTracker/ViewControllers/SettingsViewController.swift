//
//  SettingsViewController.swift
//  WaterTracker
//
//  Created by 김건우 on 8/2/23.
//

import UIKit

protocol SettingsDelegate: AnyObject {
    func didPressedOkButton()
}

final class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    
    var waterManager: WaterDataManager!
    weak var delegate: SettingsDelegate?
    var waterIntakeGoalPerDay: Int?
    
    override func loadView() {
        self.view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        addTarget()
        configureSheet()
        
        if let appDeleagte = UIApplication.shared.delegate as? AppDelegate {
            waterManager = appDeleagte.waterManager
        }
    }
    
    private func setupData() {
        settingsView.waterIntakeGoalPerDay = waterIntakeGoalPerDay
    }
    
    private func addTarget() {
        settingsView.okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
    }
    
    private func configureSheet() {
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.preferredCornerRadius = 25.0
        self.sheetPresentationController?.prefersGrabberVisible = true
    }
    
    @objc func okButtonPressed() {
        let goal = self.settingsView.waterIntakeGoalPerDay ?? 0
        // 목표 설정에 성공한 경우
        if waterManager.setWaterIntakeGoalPerDay(goal) {
            delegate?.didPressedOkButton()
            dismiss(animated: true)
        // 실패한 경우
        } else {
            let minimumWaterIntakeTarget = AppSetting.minimumWaterIntakeTarget
            let maximumWaterInatkeTarget = AppSetting.maximumWaterIntakeTarger
            
            let title = "목표 설정 실패"
            let message = "목표를 \(minimumWaterIntakeTarget)~\(maximumWaterInatkeTarget)ml 사이로 설정해주세요."
            
            let alertVC = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let okButton = UIAlertAction(title: "확인", style: .default)
            alertVC.addAction(okButton)
            
            present(alertVC, animated: true)
        }
    }
}
