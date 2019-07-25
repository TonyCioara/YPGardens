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
        [waterView].forEach { (view) in
            self.addSubview(view)
        }
        
        waterView.backgroundColor = Color.getGradientColor(percentage: CGFloat(min(1, plant.waterLevel)))
        waterView.snp.makeConstraints { (make) in
            make.bottom.left.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(min(1, plant.waterLevel))
        }
        
//        limitView.snp.makeConstraints { (make) in
//            make.bottom.left.top.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(min(1, plant.waterLimit))
//        }
    }
    
//    Views
    private let waterView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.mainBlue
        return view
    }()
    
    private struct Color {
        let r: CGFloat
        let g: CGFloat
        let b: CGFloat
        
        static func getGradientColor(percentage: CGFloat) -> UIColor {
            let from = Color(r: 229, g: 109, b: 0)
            let to = Color(r: 0, g: 109, b: 229)
            return UIColor(
                red: (from.r + (to.r - from.r) * percentage) / 255,
                green: (from.g + (to.g - from.g) * percentage) / 255,
                blue: (from.b + (to.b - from.b) * percentage) / 255,
                alpha: 1)
            
        }
    }
}
