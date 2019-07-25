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
        waterLevelView.setup(plant: plant)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [headerImageView, plantDescriptionLabel, waterLevelView].forEach { (view) in
            self.view.addSubview(view)
        }
        
        headerImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(headerImageView.snp.height).multipliedBy(1.62)
        }
        
        waterLevelView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom)
            make.height.equalTo(8)
        }
        
        plantDescriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(waterLevelView.snp.bottom).offset(16)
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
    
    private let waterLevelView: WaterLevelView = {
        let view = WaterLevelView()
        return view
    }()
}
