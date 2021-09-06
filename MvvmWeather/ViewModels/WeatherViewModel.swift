//
//  File.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation


class WeatherViewModel {
    let weather: WeatherData
    
    init(_ weatherData: WeatherData) {
        self.weather = weatherData
    }
    
    var city: String {
        return weather.name
    }
    
    var temperature: Double {
        return weather.main.temp
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
}
