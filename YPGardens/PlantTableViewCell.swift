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
    
    func setup(plant: Plant) {
        plantImageView.image = plant.image
        plantNameLabel.text = plant.name
        plantDescriptionLabel.text = plant.description
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        [plantImageView, plantNameLabel, plantDescriptionLabel].forEach { (view) in
            containerView.addSubview(view)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview().inset(8)
        }
        
        plantImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(plantImageView.snp.height).multipliedBy(1.62)
        }
        
        plantNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(plantImageView.snp.bottom).offset(16)
        }
        
        plantDescriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(plantNameLabel.snp.bottom).offset(8)
        }
    }
    
//    Views
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.6
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    private let plantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.subtitile
        return label
    }()
    
    private let plantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.subtext
        label.numberOfLines = 3
        return label
    }()
}
