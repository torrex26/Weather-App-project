//
//  APIURLS.swift
//  WeatherApp
//
//  Created by Антон on 26.01.2021.
//

import Foundation

let CURRENTLOCATION_URL = "https://api.weatherbit.io/v2.0/current?&lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.logitude!)&key=3328df65ded34aceb71d0ce9b2469055"
let CURRENTLOCATIONWEEKLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.logitude!)&days=7&key=3328df65ded34aceb71d0ce9b2469055"
let CURRENTLOCATIONHOURLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/hourly?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.logitude!)&hours=24&key=3328df65ded34aceb71d0ce9b2469055"
