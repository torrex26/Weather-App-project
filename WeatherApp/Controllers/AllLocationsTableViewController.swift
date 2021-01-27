//
//  AllLocationsTableViewController.swift
//  WeatherApp
//
//  Created by Антон on 27.01.2021.
//

import UIKit

class AllLocationsTableViewController: UITableViewController {

    
    var weatherData: [CityTempData]?
    var savedLocations: [WeatherLocation]?
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserDefaults()
        
        
    
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.count ?? 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainWeatherTableViewCell
        if weatherData != nil {
            cell.generateCell(weatherData: weatherData![indexPath.row])
        }
        return cell
    }
    
    //TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return indexPath.row != 0
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locationToDelete = weatherData?[indexPath.row]
            weatherData?.remove(at: indexPath.row)
            removeLocationFromSavedLocations(location: locationToDelete!.city)
            tableView.reloadData()
        }
    }
    
    private func removeLocationFromSavedLocations(location: String) {
        if savedLocations != nil {
            for i in 0..<savedLocations!.count {
                let tempLocation = savedLocations![i]
                if tempLocation.city == location {
                    savedLocations!.remove(at: i)
                    saveNewLocationsToUserDefaults()
                    return
                }
            }
        }
    }
    
    private func saveNewLocationsToUserDefaults() {
        userDefaults.setValue(try? PropertyListEncoder().encode(savedLocations!), forKey: "Locations")
        userDefaults.synchronize()
    }
    
    //Mark: UserDefaults
    private func loadFromUserDefaults() {
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            savedLocations = try? PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
            print("we have \(savedLocations?.count) locotaions in UD")
        }
    }
    
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseLocationSeg" {
            let vc = segue.destination as! ChooseCityViewController
            vc.delegate = self
        }
    }
}


extension AllLocationsTableViewController: ChooseCityViewControllerDelegate {
    func didAdd(newLocation: WeatherLocation) {
        print("we have added new location", newLocation.country, newLocation.city)
    }
}
