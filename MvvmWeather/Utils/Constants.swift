//
//  Constants.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

struct Constants {
    struct Urls {
        static func urlForWeatherByCity(city: String) -> URL {
            let unit = UserDefaults.standard.value(forKey: "unit") as? String ?? "imperial"
            
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&units=\(unit)&appid=9aa8eb47ca75209cd4c3bccc88045531")!
        }
    }
}
