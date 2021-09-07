//
//  File.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation


class WeatherViewModel {
    let weather: WeatherData
    var temperature: Double
    
    init(_ weatherData: WeatherData) {
        self.weather = weatherData
        self.temperature = weatherData.main.temp
    }
    
    var city: String {
        return weather.name
    }
}

class WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherViewModel(_ viewModel: WeatherViewModel) {
        weatherViewModels.append(viewModel)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    func updateUnit(to unit: TemperatureUnit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
    private func toCelsius() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature - 32) * 5/9
            return weatherModel
        }
    }
    private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.temperature = (weatherModel.temperature * 9/5) + 32
            return weatherModel
        }
    }
    
}
