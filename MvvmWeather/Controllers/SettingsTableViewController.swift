//
//  SettingsTableViewController.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/7.
//

import Foundation
import UIKit

protocol SettingsTableViewControllerDelegate {
    func settingsDone(viewModel: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsTableViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Selectors
    @IBAction func done() {
        if let delegate = self.delegate {
            delegate.settingsDone(viewModel: settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",
                                                 for: indexPath)
        let settingsItem = settingsViewModel.units[indexPath.row]
        cell.textLabel?.text = settingsItem.displayName
        cell.selectionStyle = .none
        
        /* 若 VM 中的溫度單位已被選取，將 cell 樣式換成打勾 */
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // uncheck all cells
        /* ⭐️    .visibleCells 可視範圍內的所有 Cell  */
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = TemperatureUnit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    
}
