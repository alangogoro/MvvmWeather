//
//  TableVIewDataSource.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/11.
//

import Foundation
import UIKit

class TableViewDataSource<CellType,ViewModel>: NSObject,
                                               UITableViewDataSource
where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [ViewModel]
    /* ⭐️ 這個屬性須傳入 Cell類別 和 cell 需要的 ＶiewModel
     * 在回呼函式中，設定 cell 的 UI  佈局 */
    let configureCell: (CellType, ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType, ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(cellIdentifier) not found")
        }
        
        let viewModel = items[indexPath.row]
        configureCell(cell, viewModel)
        
        return cell
    }
    
}
