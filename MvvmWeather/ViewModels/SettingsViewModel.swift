//
//  SettingsViewModel.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/7.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension TemperatureUnit {
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

class SettingsViewModel {
    
    let units = TemperatureUnit.allCases
    private var _selectedUnit: TemperatureUnit = .celsius
    
    var selectedUnit: TemperatureUnit {
        // Enum(String) 的 Getter
        get {
            if let value = UserDefaults.standard.value(forKey: "unit") as? String {
                return TemperatureUnit(rawValue: value)!
            }
            return _selectedUnit
        }
        // Enum(String) 的 Setter
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "unit")
        }
    }
    
}
