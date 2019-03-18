//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Alice Liang on 3/17/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherUrl = UrlBase + UrlAPIKey + coordinates
        
        Alamofire.request(weatherUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("Cound not return a temperature")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
