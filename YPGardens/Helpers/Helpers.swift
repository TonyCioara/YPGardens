//
//  Helpers.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/26/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation

class Helpers {
    
    /// Returns values of 0-1, representing the percentage.
    static func calculateWaterPercentage(waterLevels: [WaterLevelUpdate]) -> Float {
        if let last = waterLevels.last {
            if last.waterLevel == .dry {
                return 0
            }
        } else if waterLevels.count < 3 {
            return 3 // Estimate
        }
        var timeIntervals = [TimeInterval]()
        for index in 0..<waterLevels.count - 1 {
            let item1 = waterLevels[index]
            let item2 = waterLevels[index + 1]
            if item1.waterLevel == .wet && item2.waterLevel == .dry {
                let timeInterval = item2.date.timeIntervalSince(item1.date)
                timeIntervals.append(timeInterval)
            }
        }
        
        var total: Float = 0
        for item in timeIntervals {
            total += Float(item)
        }
        
        let averageTime = total / Float(timeIntervals.count)
        
        guard let lastWatered = calculateLastWatered(waterLevels: waterLevels) else {
            return 0
        }
        let today = Date()
        
        let timeSinceLastWatered = Float(today.timeIntervalSince(lastWatered))
        
        let percentage = (averageTime - timeSinceLastWatered) / averageTime
        return max(0.1, percentage)
    }
    
    static func calculateLastWatered(waterLevels: [WaterLevelUpdate]) -> Date? {
        for reverseIndex in 1...waterLevels.count {
            let index = waterLevels.count - reverseIndex
            let item = waterLevels[index]
            if item.waterLevel == .wet {
                return item.date
            }
        }
        return nil
    }
}
