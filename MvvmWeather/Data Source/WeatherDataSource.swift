//
//  WeatherDataSource.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/10.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier = "WeatherCell"
    private var weatherListViewModel: WeatherListViewModel
    
    init(_ weatherListViewModel: WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
 
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? WeatherCell else {
            fatalError("\(cellIdentifier) not found")
        }
        
        let weahterViewModel = weatherListViewModel.modelAt(indexPath.row)
        // cell.configure(WeatherViewModel)
        
        return cell
    }
    
}
