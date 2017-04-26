//
//  SelectableRow.swift
//  TableTie
//
//  Created by Vladimir Kofman on 24/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

/**
 Wrapper for AnyRow and select closure. Conforms to Row, so it can be used as an input for Adapter. Adapter will identify `SelectableRow`'s instances, and will store the select closures for later.
 */
public struct SelectableRow: AnyRow {
    var selectClosure: ()->Void
    var row: AnyRow
    
    public init<T:Row>(_ row: T, _ selectClosure: @escaping @autoclosure ()->Void) {
        self.row = row
        self.selectClosure = selectClosure
    }
    
    /// SelectableRow serves just as a wrapper for AnyRow, so AnyRow methods shouldn't be used
    public func _dequeueCell(tableView: UITableView) -> UITableViewCell { fatalError() }
    public func _configure(cell: UITableViewCell) { fatalError() }
}
