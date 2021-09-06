//
//  WeatherCell.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ weatherViewModel: WeatherViewModel) {
        cityNameLabel.text = weatherViewModel.city
        temperatureLabel.text = "\(weatherViewModel.temperature.formatAsDegree())"
    }
}
