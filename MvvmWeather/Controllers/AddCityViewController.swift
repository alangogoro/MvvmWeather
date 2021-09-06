//
//  AddCityViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    // MARK: - Lifecycle
    
    // MARK: - Selectors
    @IBAction func save() {
        if let city = cityNameTextField.text {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=9aa8eb47ca75209cd4c3bccc88045531")!
            let resource = Resource<Any>(url: url) { data in
                return data
            }
            
            Webservice().load(resource: resource) { result in
                
            }
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
     
}
