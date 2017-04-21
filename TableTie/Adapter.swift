//
//  TableDapter.swift
//  TableDapter
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit

public class Adapter: NSObject {
    fileprivate var sections: [Section<AnyRow>] = []
    
    fileprivate func row(for indexPath: IndexPath) -> AnyRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    public override init() {
        super.init()
    }
    
    public init(_ sections:[Section<AnyRow>]) {
        super.init()
        
        set(sections)
    }
    
    public init(_ rows: [AnyRow]) {
        super.init()
        
        set(rows)
    }
    
    public func set(_ sections: [Section<AnyRow>]) {
        self.sections = sections
    }
    
    public func set(_ rows: [AnyRow]) {
        set([Section(nil, footer: nil, rows)])
    }
}

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

extension Adapter: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return row(for: indexPath).rowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row(for: indexPath).didSelect()
    }
}
