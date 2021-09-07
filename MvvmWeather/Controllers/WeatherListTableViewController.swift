//
//  WeatherListTableViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

class WeahterListTableViewController: UITableViewController,
                                      AddCityViewControllerDelegate,
                                      SettingsTableViewControllerDelegate {
    
    // MARK: - Properties
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: TemperatureUnit!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let value = UserDefaults.standard.value(forKey: "unit") as? String {
            lastUnitSelection = TemperatureUnit(rawValue: value)
        }
        
        setupDefaultsSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherSegue" {
            guard let nav = segue.destination as? UINavigationController else {
                debugPrint("Failed to parse Segue destination to NavigationController")
                return
            }
            
            guard let addCityController = nav.viewControllers.first as? AddCityViewController else {
                debugPrint("AddCityViewController not found")
                return
            }
            addCityController.delegate = self
        }
        else if segue.identifier == "SettingsTableViewController" {
            guard let nav = segue.destination as? UINavigationController else {
                debugPrint("Failed to parse Segue destination to NavigationController")
                return
            }
            
            guard let settingsController = nav.viewControllers.first as? SettingsTableViewController else {
                debugPrint("SettingsTableViewController not found")
                return
            }
            settingsController.delegate = self
        }
    }
    
    // MARK: - Helpers
    private func setupDefaultsSettings() {
        let userDefautlts = UserDefaults.standard
        if userDefautlts.value(forKey: "unit") == nil {
            userDefautlts.setValue(TemperatureUnit.fahrenheit.rawValue, forKey: "unit")
        }
    }
    
    // MARK: - AddCityViewControllerDelegate
    func didSave(weatherViewModel: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(weatherViewModel)
        self.tableView.reloadData()
    }
    // MARK: - SettingsTableViewControllerDelegate
    func settingsDone(viewModel: SettingsViewModel) {
        if lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = TemperatureUnit(rawValue: viewModel.selectedUnit.rawValue)
        }
    }
    
    // MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell",
                                                 for: indexPath) as! WeatherCell
        let weatherViewModel = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherViewModel)
        return cell
    }
    
    
}
