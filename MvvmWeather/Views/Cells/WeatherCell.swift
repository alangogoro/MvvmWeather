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
    
    func configure(_ viewModel: WeatherViewModel) {
        cityNameLabel.text = viewModel.city
        temperatureLabel.text = "\(viewModel.temperature.formatAsDegree())"
    }
}
