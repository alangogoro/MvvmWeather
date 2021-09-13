//
//  WeatherListViewModelTests.swift
//  MvvmWeatherTests
//
//  Created by usr on 2021/9/13.
//

import XCTest
@testable import MvvmWeather

class WeatherListViewModelTests: XCTestCase {
    
    private var weatherListViewModel: WeatherListViewModel!
    
    override func setUp() {
        super.setUp()
        
        weatherListViewModel = WeatherListViewModel()
        
        let taipei = WeatherData(name: "Taipei", main: Weather(temp: 90, humidity: 80))
        let taichung = WeatherData(name: "Taichung", main: Weather(temp: 86, humidity: 60))
        let kaohsiung = WeatherData(name: "Taichung", main: Weather(temp: 77, humidity: 60))
        weatherListViewModel.addWeatherViewModel(WeatherViewModel(taipei))
        weatherListViewModel.addWeatherViewModel(WeatherViewModel(taichung))
        weatherListViewModel.addWeatherViewModel(WeatherViewModel(kaohsiung))
    }
    
    func test_should_be_able_to_convert_to_celsius_successfully() {
        
        /* 已換算好的溫度答案: [Double] */
        let celsiusTemp = [32.22, 30, 25]
        /* 欲測試換算溫度結果是否正確的方法 */
        weatherListViewModel.updateUnit(to: .celsius)
        
        for (index, vm) in weatherListViewModel.weatherViewModels.enumerated() {
            /* ➡️ 華氏→攝氏會有除不盡的小數，利用 round(Double) 取整數作比對 */
            let updates = round(vm.temperature)
            let celsius = round(celsiusTemp[index])
            XCTAssertEqual(updates, celsius)
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
}
