//
//  ForecastForEveryHour.swift
//  WeatherApp
//
//  Created by Антон on 21.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON



// Forecast for every hour

class forecastFEH {

   private var _date: Date!
   private var _temp: Double!
   private var _weatherImage: String!
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    
    var weatherImage: String {
        if _weatherImage == nil {
            _weatherImage = ""
        }
        return _weatherImage
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        
        let json = JSON(weatherDictionary)
        
        self._temp = json["temp"].double
        self._date = currentDateFromUnix(unixDate: json["ts"].double!)
        self._weatherImage = json["weather"]["icon"].stringValue
        
    }
    
    class func downloadHourlyForecast(location: WeatherLocation,completion: @escaping (_ ForecastFEH: [forecastFEH]) -> Void) {
       
        var FORECASTPEH_URL: String!
        
        if !location.currentLocation {
            FORECASTPEH_URL = String(format: "https://api.weatherbit.io/v2.0/forecast/hourly?city=%@,%@&hours=24&key=3328df65ded34aceb71d0ce9b2469055", location.city, location.countryCode)
        } else {
            FORECASTPEH_URL = CURRENTLOCATIONHOURLYFORECAST_URL
        }
        
        
        Alamofire.request(FORECASTPEH_URL).responseJSON { (response) in
            
            let result = response.result
            
            var forecastArray: [forecastFEH] = []
            
            if result.isSuccess {
                
                if let dictionary = result.value as? Dictionary<String, AnyObject> {
                    if let list = dictionary["data"] as? [Dictionary<String, AnyObject>] {
                        
                        for item in list {
                            let forecast = forecastFEH(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                
                completion(forecastArray)
            } else {
                completion(forecastArray)
               // print("no forecast data")
            }
            
            
        }
        
    }
    
}
