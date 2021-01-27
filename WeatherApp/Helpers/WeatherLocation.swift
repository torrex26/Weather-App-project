//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Антон on 26.01.2021.
//

import Foundation


struct WeatherLocation: Codable, Equatable {
    
    var city: String!
    var country: String!
    var countryCode: String!
    var currentLocation: Bool!
}


