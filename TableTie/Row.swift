//
//  Row.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

/**
 All row items to be displayed should conform to this protocol.
*/
public protocol Row: AnyRow {
    associatedtype Cell: UITableViewCell
    
    /// "Private" method, please don't override
    func _dequeueCell(tableView: UITableView, reuseIdentifier: String) -> UITableViewCell
    
    /**
     The only required method to override. Please provide the correct type for cell parameter. The cell will be automatically created and registered for reuse.
     */
    func configure(cell: Cell)
}

public extension Row {
    func _dequeueCell(tableView: UITableView) -> UITableViewCell {
        return _dequeueCell(tableView: tableView, reuseIdentifier: reuseIdentifier)
    }
    
    func _dequeueCell(tableView: UITableView, reuseIdentifier: String) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if cell == nil {
            tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        }
        
        return cell ?? UITableViewCell()
    }
}

public extension Row {
    func _configure(cell: UITableViewCell) {
        guard let cell = cell as? Cell else { return }
        
        configure(cell: cell)
    }
}
