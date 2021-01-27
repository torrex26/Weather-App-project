//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Антон on 24.01.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    //MARK: Outlets
    
    @IBOutlet weak var weatherDaysLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func generateCell(forecast: WeeklyWeatherForecast) {
        
        weatherDaysLabel.text = forecast.date.dayOfTheWeek()
        weatherImageView.image = getWeatherImageFor(forecast.weatherImage)
        tempLabel.text = "\(forecast.temp)"
        
        
    }
    
    
    
}
