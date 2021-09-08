//
//  WeatherListViewModel.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/8.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(_ viewModel: WeatherViewModel) {
        weatherViewModels.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    mutating func updateUnit(to unit: TemperatureUnit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
    private mutating func toCelsius() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature - 32) * 5/9
            return weatherModel
        }
    }
    
    private mutating func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature * 9/5) + 32
            return weatherModel
        }
    }
    
}
