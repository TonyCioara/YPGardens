//
//  PlantDetailsViewController.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/24/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

class PlantDetailsViewController: UIViewController {
    
    init(plant: Plant) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupViews()
        title = plant.name
        headerImageView.image = plant.image
        plantDescriptionLabel.text = plant.description
        waterPercentageLabel.text = String(plant.waterLevel * 100) + "%"
//        waterLevelView.setup(plant: plant)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [headerImageView, dotView, plantDescriptionLabel, waterLevelView, waterDropIcon, waterPercentageLabel].forEach { (view) in
            self.view.addSubview(view)
        }
        
        headerImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(headerImageView.snp.height).multipliedBy(1.62)
        }
        
        dotView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalTo(plantDescriptionLabel.snp.centerY)
            make.height.width.equalTo(6)
        }
        
        plantDescriptionLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(headerImageView.snp.bottom).offset(16)
            make.left.equalTo(dotView.snp.right).offset(8)
        }
        
        waterDropIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalTo(waterPercentageLabel.snp.centerY)
            make.height.equalTo(14)
            make.width.equalTo(9)
        }
        
        waterPercentageLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(plantDescriptionLabel.snp.bottom).offset(16)
            make.left.equalTo(waterDropIcon.snp.right).offset(8)
        }
    }
    
//    Views
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let plantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.numberOfLines = 3
        return label
    }()
    
    private let waterDropIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "water-drop")
        return imageView
    }()
    
    private let waterPercentageLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.textColor = AppColors.mainBlue
        return label
    }()
    
    private let waterLevelView: WaterLevelView = {
        let view = WaterLevelView()
        return view
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .gray
        return view
    }()
}
