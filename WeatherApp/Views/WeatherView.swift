//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Антон on 23.01.2021.
//

import UIKit


class WeatherView: UIView {

   
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var botContainer: UIView!
    @IBOutlet weak var hourlyWeather: UICollectionView!
    @IBOutlet weak var weatherInfo: UICollectionView!
    @IBOutlet weak var weeklyWeatherTable: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: Vars
    
    var currentWeather: CurrentWeather!
    var weeklyWeatherForecastData: [WeeklyWeatherForecast] = []
    var dailyWeatherForecastData: [forecastFEH] = []
    var weatherInfoData: [WeatherInfo] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        mainInit()
    }
    
    
    
    private func mainInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupTableView()
        setupHourlyCollectionView()
        setupInfoCollectionView()
        
        
        
    }
    
    private func setupTableView() {
        weeklyWeatherTable.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        weeklyWeatherTable.delegate = self
        weeklyWeatherTable.dataSource = self
        weeklyWeatherTable.tableFooterView = UIView()
        
    }
    
    private func setupHourlyCollectionView() {
        hourlyWeather.register(UINib(nibName: "ForecastCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        
        hourlyWeather.dataSource = self
        
        
    }
    
    private func setupInfoCollectionView() {
        weatherInfo.register(UINib(nibName: "WeatherInfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        
        weatherInfo.dataSource = self
        
    }
    
    func refreshData() {
        setupCurrentWeather()
        setupWeatherInfo()
        weatherInfo.reloadData()
    }
    
    private func setupCurrentWeather() {
        cityNameLabel.text = currentWeather.city
        dateLabel.text = "\(currentWeather.date.shortDate())"
        tempLabel.text = "\(currentWeather.currentTemp)"
        weatherInfoLabel.text = currentWeather.weatherType
    }
    
    
    private func setupWeatherInfo() {
        let windInfo = WeatherInfo(infoText: String(format: "%.1f m/s", currentWeather.windSpeed), nameText: nil, image: getWeatherImageFor("wind"))
        let humidity = WeatherInfo(infoText: String(format: "%.0f ", currentWeather.humidity), nameText: nil, image: getWeatherImageFor("humidity"))
        let pressure = WeatherInfo(infoText: String(format: "%.0f mb", currentWeather.pressure), nameText: nil, image: getWeatherImageFor("pressure"))
        let visibility = WeatherInfo(infoText: String(format: "%.0f km", currentWeather.visibility), nameText: nil, image: getWeatherImageFor("visibility"))
        let tempInfo = WeatherInfo(infoText: String(format: "%.1f", currentWeather.infoTemp), nameText: nil, image: getWeatherImageFor("temp"))
        let uvInfo = WeatherInfo(infoText: String(format: "%.1f", currentWeather.uv), nameText: "UV Index", image: nil)
        let sunriseInfo = WeatherInfo(infoText: currentWeather.sunrise, nameText: nil, image: getWeatherImageFor("sunrise"))
        let sunsetInfo = WeatherInfo(infoText: currentWeather.sunset, nameText: nil, image: getWeatherImageFor("sunset"))
        weatherInfoData = [windInfo, humidity, pressure, visibility, tempInfo, uvInfo, sunriseInfo, sunsetInfo]
    }    
}

extension WeatherView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        
        cell.generateCell(forecast: weeklyWeatherForecastData[indexPath.row])
        
        return cell
    }
    
}

extension WeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourlyWeather {
            
            return dailyWeatherForecastData.count
        } else {
            return weatherInfoData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hourlyWeather {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ForecastCollectionViewCell
            
        
            cell.generateCell(weather: dailyWeatherForecastData[indexPath.row])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherInfoCollectionViewCell
            
        
            cell.generateCell(weatherInfo: weatherInfoData[indexPath.row])
            return cell
        }
    }
    
    
}
