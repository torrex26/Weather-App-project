//
//  MainWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Антон on 27.01.2021.
//

import UIKit

class MainWeatherTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func generateCell(weatherData: CityTempData) {
        cityLabel.text = weatherData.city
        cityLabel.adjustsFontSizeToFitWidth = true
        tempLabel.text = String(format: "%.0f C", weatherData.temp)
        //TODO: make temp format C and F
    }

}
