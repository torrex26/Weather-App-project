//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Антон on 23.01.2021.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var weatherLocation: WeatherLocation!
    
    let userDefaults = UserDefaults.standard
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D!
    
    var allLocations: [WeatherLocation] = []
    var allWeatherViews: [WeatherView] = []
    var allWeatherData: [CityTempData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManagerStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthCheck()
     
    }
    
    //MARK: Download Weather
    
    private func getWeather() {
        loadLocationsFromUserDefaults()
        createWeatherViews()
        addWeatherToScrollView()
    }
    
    private func createWeatherViews() {
        for _ in allLocations {
            allWeatherViews.append(WeatherView())
        }
    }
    
    private func addWeatherToScrollView() {
        for i in 0..<allWeatherViews.count {
            let weatherView = allWeatherViews[i]
            let location = allLocations[i]
            getCurrentWeather(weatherView: weatherView, location: location)
            getWeeklyWeather(weatherView: weatherView, location: location)
            getHourlyWeather(weatherView: weatherView, location: location)
            
            let xPos = self.view.frame.width * CGFloat(i)
            weatherView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(weatherView)
            scrollView.contentSize.width = weatherView.frame.width * CGFloat(i + 1)
            
        }
    }
    
    private func getCurrentWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather(location: weatherLocation) { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: location) { (weatherForecasts) in
            weatherView.weeklyWeatherForecastData = weatherForecasts
            weatherView.weeklyWeatherTable.reloadData()
        }
    }

    
    private func getHourlyWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        forecastFEH.downloadHourlyForecast(location: location) { (weatherForecasts) in
            weatherView.dailyWeatherForecastData = weatherForecasts
            weatherView.hourlyWeather.reloadData()
        }
    }
    
    //MARK: LoadLocations from User Defaults
    private func loadLocationsFromUserDefaults() {
        let currentLocation = WeatherLocation(city: "", country: "", countryCode: "", currentLocation: true)
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            allLocations = try! PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
            allLocations.insert(currentLocation, at: 0)
        } else {
            print("no user data in user defaults")
            allLocations.append(currentLocation)
        }
    }
    
    
    //Location Manager
    
    private func locationManagerStart() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.delegate = self
        }
        locationManager!.startMonitoringSignificantLocationChanges()
    }
    private func locationManagerStop() {
        if locationManager != nil {
            locationManager!.stopMonitoringSignificantLocationChanges()
        }
    }
    
    private func locationAuthCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            currentLocation = locationManager!.location?.coordinate
            if currentLocation != nil {
                LocationService.shared.latitude = currentLocation.latitude
                LocationService.shared.logitude = currentLocation.longitude
                
                getWeather()
            } else {
                locationAuthCheck()
            }
        } else {
            locationManager?.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }
}

extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location, \(error.localizedDescription)")
    }
}
