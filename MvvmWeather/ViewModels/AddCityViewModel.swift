//
//  AddCityViewModel.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

class AddCityViewModel {
    func addWeatherFor(city: String, completion: @escaping (WeatherViewModel) -> Void) {
        let weatherUrl = Constants.Urls.urlForWeatherByCity(city: city)
        
        let weatherResource = Resource<WeatherData>(url: weatherUrl) { data in
            let response  = try? JSONDecoder().decode(WeatherData.self, from: data)
            return response
        }
        
        Webservice().load(resource: weatherResource) { result in
            if let weatherData = result {
                let viewModel = WeatherViewModel(weatherData)
                completion(viewModel)
            }
        }
    }
}
