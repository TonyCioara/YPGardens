//
//  WaterLevelUpdate.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/26/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation

struct WaterLevelUpdate: Codable {
    enum WaterLevel: Int, Codable {
        case wet = 1
        case dry = 0
    }
    let waterLevel: WaterLevel
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case waterLevel = "water_level"
        case date
    }
}
