//
//  Helper.swift
//  WeatherApp
//
//  Created by Антон on 21.01.2021.
//

import Foundation
import UIKit

func currentDateFromUnix(unixDate: Double?) -> Date? {
    
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else {
        return Date()
    }
}


func getWeatherImageFor(_ type: String) -> UIImage? {
    return UIImage(named: type)
}

