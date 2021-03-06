//
//  SettingsViewModelTests.swift
//  MvvmWeatherTests
//
//  Created by usr on 2021/9/13.
//

import XCTest
@testable import MvvmWeather

class SettingsViewModelTests: XCTestCase {
    
    private var settingsViewModel: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        settingsViewModel = SettingsViewModel()
    }

    /// 檢查溫度制的預設永遠是攝氏
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        XCTAssertEqual(settingsViewModel.selectedUnit, .fahrenheit)
    }
    
    func test_should_return_correct_display_name_for_fahrenheit() {
        XCTAssertEqual(settingsViewModel.selectedUnit.displayName, "Fahrenheit")
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        settingsViewModel.selectedUnit = .celsius
        
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override class func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }

}
