//
//  Extensions.swift
//  WeatherApp
//
//  Created by Антон on 23.01.2021.
//

import Foundation

extension Date {
    
    func shortDate() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d"
        return dateFormat.string(from: self)
    }
    
    func currentTime() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: self)
        
    }
    
    func dayOfTheWeek() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE"
        return dateFormat.string(from: self)
    }
    
    
}
