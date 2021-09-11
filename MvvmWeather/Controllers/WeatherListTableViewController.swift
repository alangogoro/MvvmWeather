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
    private var dataSource: TableViewDataSource<WeatherCell,WeatherViewModel>!
    //private var lastUnitSelection: TemperatureUnit!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        dataSource = TableViewDataSource(cellIdentifier: "WeatherCell",
                                         items: weatherListViewModel.weatherViewModels,
                                         configureCell: { cell, vm in
                                            cell.cityNameLabel.text = vm.city
                                            cell.temperatureLabel.text = vm.temperature.formatAsDegree()
                                         })
        /* ⭐️ 設定 TableView 的 dataSource 為自定義的
         * 就不用在本頁去寫 TableView dataSource 的 code */
        tableView.dataSource = dataSource
        
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
    
    
}

// MARK: - AddCityViewControllerDelegate
extension WeahterListTableViewController: AddCityViewControllerDelegate {
    func didSave(weatherViewModel: WeatherViewModel) {
        debugPrint(weatherViewModel.city)
        
        weatherListViewModel.addWeatherViewModel(weatherViewModel)
        /* ⛔️ Call by Value ←→ Call by Reference 差異
         * dataSource 擁有的是 copy value 的 viewModels
         * 因此即使更新本頁的 viewModels，dataSource 仍不會改變，tableView 也不會更新
         * 需要重新對 dataSource 的 items 賦值，才能達成更新 tableView 目的 */
        dataSource.updateItems(weatherListViewModel.weatherViewModels)
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
