//
//  WaterView.swift
//  WaterTracker
//
//  Created by 김건우 on 8/1/23.
//

import UIKit

final class WaterView: UIView {
    
    // MARK: - LABELS
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let gearshape = UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysTemplate)
        button.setImage(gearshape, for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date.now.toFormat("M월 d일")
        label.font = UIFont.systemFont(ofSize: 46, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(description Label)" // TEMP
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            dateLabel, descriptionLabel
        ])
        st.axis = .vertical
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // MARK: - BUTTONS
    
    var glassWaterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Glass"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var glassWaterLabel: UILabel = {
        let label = UILabel()
        label.text = "100ml"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var glassWaterStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            glassWaterButton, glassWaterLabel
        ])
        st.axis = .vertical
        st.spacing = 5
        st.alignment = .center
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    var bottleWaterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Bottle"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var bottleWaterLabel: UILabel = {
        let label = UILabel()
        label.text = "200ml"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottleWaterStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            bottleWaterButton, bottleWaterLabel
        ])
        st.axis = .vertical
        st.spacing = 5
        st.alignment = .center
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    var flaskWaterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Flask"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var flaskWaterLabel: UILabel = {
        let label = UILabel()
        label.text = "500ml"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var flaskWaterStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            flaskWaterButton, flaskWaterLabel
        ])
        st.axis = .vertical
        st.spacing = 10
        st.alignment = .center
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var waterButtonsStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            glassWaterStackView, bottleWaterStackView, flaskWaterStackView
        ])
        st.axis = .horizontal
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .equalSpacing
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // MARK: - UIVEIW
    
    var waterProgressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - PROPERTIES
    
    private let buttonWidth: CGFloat = 80.0
    private let buttonHeight: CGFloat = 80.0
    
    lazy var waterProgressViewHeightConstraint: NSLayoutConstraint = waterProgressView.heightAnchor.constraint(equalToConstant: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        backgroundColor = UIColor.white
        [settingsButton, waterProgressView, labelStackView, waterButtonsStackView].forEach { self.addSubview($0) }
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            glassWaterButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            glassWaterButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            bottleWaterButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            bottleWaterButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            flaskWaterButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            flaskWaterButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            waterButtonsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            waterButtonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            waterButtonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            waterProgressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            waterProgressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            waterProgressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            waterProgressViewHeightConstraint
        ])
        
        super.updateConstraints()
        
    }
    
    @objc func settingsButtonPressed() {
        print("Settings Button Pressed")
    }
}
