//
//  TimeInterval+format.swift
//  WeatherGift
//
//  Created by Alice Liang on 3/23/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import Foundation


extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
