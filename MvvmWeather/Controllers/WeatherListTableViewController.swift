//
//  WeatherListTableViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

class WeahterListTableViewController: UITableViewController,
                                      AddCityViewControllerDelegate {
    
    // MARK: - Properties
    private var weatherListViewModel = WeatherListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherSegue" {
            guard let nav = segue.destination as? UINavigationController else {
                debugPrint("Failed to parse Segue destination to NavigationController")
                return
            }
            
            guard let addCityController = nav.viewControllers.first as? AddCityViewController else {
                debugPrint("Failed to parse Segue destination to AddCityViewController")
                return
            }
            
            addCityController.delegate = self
        }
    }
    
    // MARK: - Helpers
    
    // MARK: - AddCityViewControllerDelegate
    func didSave(weatherViewModel: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(weatherViewModel)
        self.tableView.reloadData()
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
