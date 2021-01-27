//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Антон on 24.01.2021.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func generateCell(weather: forecastFEH) {
        
        timeLabel.text = weather.date.currentTime()
        weatherImageView.image = getWeatherImageFor(weather.weatherImage)
        tempLabel.text = "\(weather.temp)"
    }
    
    

}
