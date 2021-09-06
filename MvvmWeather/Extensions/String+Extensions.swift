//
//  String+Extensions.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
