//
//  Double+Extensions.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

extension Double {
    
    func formatAsDegree() -> String {
        return String(format: "%.0f°", self)
    }
     
}
