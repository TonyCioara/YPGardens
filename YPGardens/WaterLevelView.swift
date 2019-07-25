//
//  WaterLevelView.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/24/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation
import UIKit

class WaterLevelView: UIView {
    
    func setup(plant: Plant) {
        setupViews(plant: plant)
    }
    
    private func setupViews(plant: Plant) {
        [waterView, limitView].forEach { (view) in
            self.addSubview(view)
        }
        
        waterView.snp.makeConstraints { (make) in
            make.bottom.left.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(min(1, plant.waterLevel))
        }
        
        limitView.snp.makeConstraints { (make) in
            make.bottom.left.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(min(1, plant.waterLimit))
        }
    }
    
//    Views
    private let waterView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let limitView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
}
