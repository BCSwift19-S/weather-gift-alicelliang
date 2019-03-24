//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Alice Liang on 3/24/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
