//
//  WeeklyWeatherForecast.swift
//  WeatherApp
//
//  Created by Антон on 21.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeeklyWeatherForecast {
    
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
    
    class func downloadWeeklyWeatherForecast(location: WeatherLocation,completion: @escaping (_ weatherForecast: [WeeklyWeatherForecast]) -> Void) {
        
        var WEEKLYFORECAST_URL: String!
        
        if !location.currentLocation {
            WEEKLYFORECAST_URL = String(format: "https://api.weatherbit.io/v2.0/forecast/daily?city=%@,%@&days=7&key=3328df65ded34aceb71d0ce9b2469055", location.city, location.countryCode)
        } else {
            WEEKLYFORECAST_URL = CURRENTLOCATIONWEEKLYFORECAST_URL
        }
        
        
        Alamofire.request(WEEKLYFORECAST_URL).responseJSON { (response) in
            
            let result = response.result
            
            var forecastArray : [WeeklyWeatherForecast] = []
            
            if result.isSuccess {
                
                if let dictionary = result.value as? Dictionary<String, AnyObject> {
                    if var list = dictionary["data"] as? [Dictionary<String, AnyObject>] {
                        
                        list.remove(at: 0) //remove current day
                       // print("number of days", list.count)
                        
                        for item in list {
                            let forecast = WeeklyWeatherForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                        
                    }
                }
                
                completion(forecastArray)
            } else {
                completion(forecastArray)
               // print("No weekly forecast")
            }
            
        }
        
    }
    
}
