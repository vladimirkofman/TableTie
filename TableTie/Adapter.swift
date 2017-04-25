//
//  Adapter.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

/**
 Partially implements UITableViewSource and UITableViewDelegate.
 */
public class Adapter: NSObject {
    
    /// Closure to call when a row is selected
    public var didSelect: ((AnyRow, UITableView, IndexPath)->Void)? = nil

    fileprivate var sections: [Section] = []
    fileprivate var selectClosures: [IndexPath : ()->Void] = [:]
    
    fileprivate func row(for indexPath: IndexPath) -> AnyRow {
        return sections[indexPath.section].rows[indexPath.row]
    }

    /// Creates an empty adapter
    public override init() {
        super.init()
    }
    
    /// Initializes the adapter with the provided sections (that may contain rows)
    public init(_ sections:[Section]) {
        super.init()
        
        set(sections)
    }
    
    /// Initializes the adapter with the provided rows (one default Section will be created)
    public init(_ rows: [AnyRow]) {
        super.init()
        
        set(rows)
    }
    
    /// Updates the adapter with the provided sections
    public func set(_ sections: [Section]) {
        self.sections = []
        self.selectClosures = [:]
        
        for (sectionIndex, section) in sections.enumerated() {
            var rows:[AnyRow] = []
            
            for (rowIndex, var row) in section.rows.enumerated() {
                if let selectableRow = row as? SelectableRow {
                    row = selectableRow.row
                    selectClosures[IndexPath(row: rowIndex, section: sectionIndex)] = selectableRow.selectClosure
                }
                
                rows.append(row)
            }
            self.sections.append(Section(section.header, footer: section.footer, rows))
        }
    }
    
    /// Updates the adapter with rows (one default Section with empty header and footer will be created)
    public func set(_ rows: [AnyRow]) {
        set([Section(nil, footer: nil, rows)])
    }
}

//MARK: UITableViewDataSource implementation

extension Adapter: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.row(for: indexPath)
        let cell = row._dequeueCell(tableView: tableView)
        
        row._configure(cell: cell)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
}

//MARK: UITableViewDataDelegate implementation

extension Adapter: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return row(for: indexPath).rowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.row(for: indexPath)
        
        selectClosures[indexPath]?()
        
        row.didSelectRow(of: tableView, at: indexPath)
        self.didSelect?(row, tableView, indexPath)
    }
}
