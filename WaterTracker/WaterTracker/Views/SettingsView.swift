//
//  SettingsView.swift
//  WaterTracker
//
//  Created by 김건우 on 8/2/23.
//

import UIKit

final class SettingsView: UIView {

    // MARK: - DidSet
    
    var waterIntakeGoalPerDay: Int? {
        didSet {
            waterIntakeGoalPerDayLabel.text = String(waterIntakeGoalPerDay ?? 0)
        }
    }
    
    // MARK: - LABELS
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "목표 설정"
        label.font = UIFont.systemFont(ofSize: 36, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let waterIntakeGoalPerDayLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - BUTTONS
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        let plus = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(plus, for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = false
        button.layer.cornerRadius = buttonWidth / 2
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        let plus = UIImage(systemName: "minus")?.withRenderingMode(.alwaysTemplate)
        button.setImage(plus, for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = false
        button.layer.cornerRadius = buttonWidth / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // okButton의 액션 함수는 SettingsViewController에 정의함
        return button
    }()
    
    // MARK: - STACK VIEW
    
    private lazy var buttonsStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            minusButton, plusButton
        ])
        st.axis = .horizontal
        st.spacing = 200
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // MARK: - PROPERTIES
    
    let buttonWidth: CGFloat = 60
    let buttonHeight: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = UIColor.white
        [descriptionLabel, buttonsStackView, waterIntakeGoalPerDayLabel, okButton].forEach { addSubview($0) }
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            plusButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            minusButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            minusButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            buttonsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 80),
            buttonsStackView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: 15),
            buttonsStackView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor, constant: -15),
            buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            waterIntakeGoalPerDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            waterIntakeGoalPerDayLabel.centerYAnchor.constraint(equalTo: buttonsStackView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            okButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            okButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        super.updateConstraints()
    }
    
    @objc func plusButtonPressed() {
        waterIntakeGoalPerDay! += 100
    }
    
    @objc func minusButtonPressed() {
        waterIntakeGoalPerDay! -= 100
    }
    
}
