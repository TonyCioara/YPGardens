//
//  WaterLevelView.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/24/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class WaterLevelView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var widthConstraint: Constraint?
    
    func setup(plant: Plant) {
        self.backgroundColor = #colorLiteral(red: 0.8628115058, green: 0.8629567623, blue: 0.8627924323, alpha: 1)
        widthConstraint?.deactivate()
        waterView.snp.makeConstraints { (make) in
            self.widthConstraint = make.width.equalToSuperview().multipliedBy(min(1, plant.waterLevel)).constraint
        }
        percentageLabel.text = String(Int(plant.waterLevel * 100)) + "%"
    }
    
    private func setupViews() {
        
        [waterView, percentageLabel].forEach { (view) in
            self.addSubview(view)
        }
        
        waterView.snp.makeConstraints { (make) in
            self.widthConstraint = make.width.equalToSuperview().constraint
            make.bottom.top.left.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
//    Views
    private let waterView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.waterBlue
        return view
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.subtitile
        label.textColor = UIColor.white
        return label
    }()
}
