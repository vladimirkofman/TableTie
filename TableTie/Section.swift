//
//  Section.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import Foundation

public struct Section {
    let header: String?
    let footer: String?
    let rows: [AnyRow]
    
    public init(_ header: String? = nil, footer: String? = nil, _ rows: [AnyRow]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}
