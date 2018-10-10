//
//  AnyRow.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

/**
 Acts as an abstract protocol for all row items to be displayed.
 All row items should conform to this protocol through Row.
 */
public protocol AnyRow {
    
    /// reuseIdentifier to use when dequeing reusable cell
    var reuseIdentifier: String { get }
    
    /// Row Height
    var rowHeight: CGFloat { get }
    
    /// Called when the row is selected
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath)
    
    /// "Private" method, don't override. Implemented in Row
    func _dequeueCell(tableView: UITableView) -> UITableViewCell
    
    /// "Private" method, don't override. Implemented in Row
    func _configure(cell: UITableViewCell)
}

/// Default implementations of AnyRow protocol
public extension AnyRow {
    
    /// Using class name as reuseIdentifier
    var reuseIdentifier: String { return String(describing: type(of: self)) }
    
    /// Default row height
    var rowHeight: CGFloat { return UITableView.automaticDimension }
    
    /// Do nothing by default
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath) {}
}
