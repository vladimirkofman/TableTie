//
//  Section.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import Foundation

/**
 Stores the information about a section in a UITableView
 */
public struct Section {
    /// header title
    let header: String?
    
    /// footer title
    let footer: String?
    
    /// rows
    let rows: [AnyRow]
    
    public init(_ header: String? = nil, footer: String? = nil, _ rows: [AnyRow]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}
