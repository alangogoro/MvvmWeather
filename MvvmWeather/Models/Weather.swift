//
//  Weather.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}

struct WeatherData: Decodable {
    let name: String
    let main: Weather
}
