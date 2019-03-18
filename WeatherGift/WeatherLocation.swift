//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Alice Liang on 3/17/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        let weatherUrl = UrlBase + UrlAPIKey + coordinates
        print(weatherUrl)
        
        Alamofire.request(weatherUrl).responseJSON { response in
            print(response)
        }
    }
}
