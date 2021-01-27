//
//  WeatherInfoCollectionVC.swift
//  WeatherApp
//
//  Created by Антон on 24.01.2021.
//

import UIKit

class WeatherInfoCollectionViewCell: UICollectionViewCell {

    
    //MARK: Outlets
    
    
    /*@IBOutlet weak var infoTopLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoBottomLabel: UILabel!
    */
    
    @IBOutlet weak var infoTopLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoBottomLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func generateCell(weatherInfo: WeatherInfo) {
        infoTopLabel.text = weatherInfo.infoText
        infoTopLabel.adjustsFontSizeToFitWidth = true
        
        if weatherInfo.image != nil {
            infoBottomLabel.isHidden = true
            infoImageView.isHidden = false
            infoImageView.image = weatherInfo.image
            
        } else {
            //no image
            infoBottomLabel.isHidden = false
            infoImageView.isHidden = true
            infoBottomLabel.adjustsFontSizeToFitWidth = true
            infoBottomLabel.text = weatherInfo.nameText
            
        }
    }
    
}
