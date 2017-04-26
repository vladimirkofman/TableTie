//
//  TableTieTests.swift
//  TableTieTests
//
//  Created by Vladimir Kofman on 25/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import XCTest
@testable import TableTie

extension String: Row {
    public func configure(cell: UITableViewCell) {
        cell.textLabel?.text = self
    }
}

class TableTieTests: XCTestCase {
    
    var adapter: Adapter!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        adapter = Adapter()
        tableView = UITableView(frame: CGRect.zero)
        
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: -
    
    func testEmptyAdapterInit() {
        XCTAssertEqual(adapter.numberOfSections(in: tableView), 0)
    }
    
    func testAdapterSetRows() {
        let arr = ["a", "b", "c"]
        adapter.set(arr)
        
        XCTAssertEqual(adapter.numberOfSections(in: UITableView()), 1)
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), arr.count)
        
    }
    
    func testCellForRow() {
        let arr = ["d", "e", "f", "g"]
        adapter.set(arr)
        
        let testRowIndex = arr.count / 2
        let cell = adapter.tableView(tableView, cellForRowAt: IndexPath(row: testRowIndex, section: 0))
        XCTAssertEqual(cell.textLabel?.text, arr[testRowIndex])
    
        adapter.set([] as! [AnyRow])
        XCTAssertEqual(adapter.numberOfSections(in: UITableView()), 1)
    }
    
//        let arr2 = ["d", "e"]
//        adapter.set(arr2)
//        XCTAssertEqual(adapter.numberOfSections(in: UITableView()), 1)
//        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), arr2.count)
//    }
    
    
}
