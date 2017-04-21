//
//  AnyRow.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

public protocol AnyRow {
    var reuseIdentifier: String { get }
    var rowHeight: CGFloat { get }
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath)
    
    func _dequeueCell(tableView: UITableView) -> UITableViewCell
    func _configure(cell: UITableViewCell)
}

public extension AnyRow {
    var reuseIdentifier: String { return String(describing: type(of: self)) }
    var rowHeight: CGFloat { return 44 }
    
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath) {}
}
