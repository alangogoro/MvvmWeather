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
