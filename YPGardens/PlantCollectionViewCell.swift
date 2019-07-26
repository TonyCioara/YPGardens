//
//  PlantTableViewCell.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/24/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import UIKit
import SnapKit

class PlantCollectionViewCell: UICollectionViewCell {
    static let id = "plantCellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var plant: Plant?
    func setup(plant: Plant) {
        plantImageView.image = plant.image
        plantNameLabel.text = plant.name
        plantDescriptionLabel.text = plant.description
        waterLevelView.setup(plant: plant)
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        [plantImageView, plantNameLabel, dotView, plantDescriptionLabel, waterButton, waterDropIcon, waterLevelView, calendarIcon, lastWateredLabel].forEach { (view) in
            containerView.addSubview(view)
        }
        plantImageView.addSubview(shadowLayerView)
        waterButton.addTarget(self, action: #selector(waterPlant), for: .touchUpInside)
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().inset(8)
        }
        
        plantImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(plantImageView.snp.height).multipliedBy(1.62)
        }
        
        
        shadowLayerView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        plantNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(plantImageView.snp.bottom).offset(-8)
        }
        
        dotView.snp.makeConstraints { (make) in
            make.centerY.equalTo(plantDescriptionLabel.snp.centerY)
            make.centerX.equalTo(waterDropIcon.snp.centerX)
            make.height.width.equalTo(6)
        }
        
        plantDescriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dotView.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(plantImageView.snp.bottom).offset(24)
        }
        
        waterDropIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(waterLevelView)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(19)
            make.width.equalTo(12)
        }
        
        waterLevelView.snp.makeConstraints { (make) in
            make.top.equalTo(plantDescriptionLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(waterDropIcon.snp.right).offset(8)
            make.height.equalTo(32)
        }
        
        calendarIcon.snp.makeConstraints { (make) in
            make.top.equalTo(waterLevelView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(14)
            make.height.width.equalTo(24)
        }
        
        lastWateredLabel.snp.makeConstraints { (make) in
            make.top.equalTo(waterLevelView.snp.bottom).offset(24)
            make.left.equalTo(calendarIcon.snp.right).offset(8)
        }
        
        waterButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(36)
        }
    }
    
    @objc func waterPlant() {
        print("Tapped: \(plantNameLabel.text!)")
    }
    
//    Views
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.6
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let shadowLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    private let plantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return imageView
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .gray
        return view
    }()
    
    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.title
        label.textColor = UIColor.white
        return label
    }()
    
    private let plantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.numberOfLines = 2
        return label
    }()
    
    private let waterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColors.lightBlue
        button.layer.cornerRadius = 4
        button.setTitle("Water me", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = AppFonts.subtitile
        return button
    }()
    
    private let waterDropIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "water-drop")
        return imageView
    }()
    
    private let waterLevelView: WaterLevelView = {
        let view = WaterLevelView(frame: CGRect.zero)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "icons8-calendar-50")
        return imageView
    }()
    
    private let lastWateredLabel: UILabel = {
        let label = UILabel()
        label.text = "Last watered: 5 days ago"
        label.font = AppFonts.body
        label.textColor = UIColor.darkGray
        return label
    }()
    
}

