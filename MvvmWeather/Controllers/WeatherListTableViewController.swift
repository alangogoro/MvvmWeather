//
//  WeatherListTableViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

class WeahterListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var weatherListViewModel = WeatherListViewModel()
    //private var lastUnitSelection: TemperatureUnit!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        if let value = UserDefaults.standard.value(forKey: "unit") as? String {
//            lastUnitSelection = TemperatureUnit(rawValue: value)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareControllerDelegates(for: segue)
    }
    
    // MARK: - Helpers
    
    private func prepareControllerDelegates(for segue: UIStoryboardSegue) {
        
        switch segue.identifier {
        case "AddCitySegue":
            guard let nav = segue.destination as? UINavigationController else {
                debugPrint("Failed to parse Segue destination to NavigationController")
                return
            }
            guard let addCityController = nav.viewControllers.first as?
                    AddCityViewController else {
                debugPrint("AddCityViewController not found")
                return
            }
            addCityController.delegate = self
            
        case "SettingsSegue":
            guard let nav = segue.destination as? UINavigationController else {
                debugPrint("Failed to parse Segue destination to NavigationController")
                return
            }
            guard let settingsController = nav.viewControllers.first as?
                    SettingsTableViewController else {
                debugPrint("SettingsTableViewController not found")
                return
            }
            settingsController.delegate = self
            
        default:
            fatalError("Wrong segue identifier")
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

// MARK: - AddCityViewControllerDelegate
extension WeahterListTableViewController: AddCityViewControllerDelegate {
    func didSave(weatherViewModel: WeatherViewModel) {
        debugPrint(weatherViewModel.city)
        weatherListViewModel.addWeatherViewModel(weatherViewModel)
        self.tableView.reloadData()
    }
}

// MARK: - SettingsTableViewControllerDelegate
extension WeahterListTableViewController: SettingsTableViewControllerDelegate {
    func settingsDone(viewModel: SettingsViewModel) {
        //if lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
        weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
        self.tableView.reloadData()
            //lastUnitSelection = TemperatureUnit(rawValue: viewModel.selectedUnit.rawValue)
        //}
    }
}
