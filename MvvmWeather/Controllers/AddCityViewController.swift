//
//  AddCityViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation
import UIKit

protocol AddCityViewControllerDelegate {
    func didSave(weatherViewModel: WeatherViewModel)
}

class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    private var addCityViewModel = AddCityViewModel()
    var delegate: AddCityViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    // MARK: - Selectors
    @IBAction func save() {
        guard let cityName = cityNameTextField.text else { return }
        addCityViewModel.addWeatherFor(city: cityName) { viewModel in
            self.delegate?.didSave(weatherViewModel: viewModel)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
     
}
