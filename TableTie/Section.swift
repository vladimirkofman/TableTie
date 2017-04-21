//
//  Section.swift
//  TableDapter
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import Foundation

public struct Section<T> {
    let header: String?
    let footer: String?
    let rows: [T]
    
    public init(_ header: String? = nil, footer: String? = nil, _ rows: [T]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
}
