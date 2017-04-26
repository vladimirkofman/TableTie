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
    
    func testAdapterInitRows() {
        let arr = ["a", "b", "c"]
        adapter = Adapter(arr)
        tableView = UITableView(frame: CGRect.zero)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        
        XCTAssertEqual(adapter.numberOfSections(in: tableView), 1)
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), arr.count)
    }
    
    func testAdapterInitSections() {
        let sections = [Section("A", ["a", "b"])]
        adapter = Adapter(sections)
        tableView = UITableView(frame: CGRect.zero)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        
        XCTAssertEqual(adapter.numberOfSections(in: tableView), 1)
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), sections[0].rows.count)
    }
    
    func testAdapterSetRows() {
        let arr = ["a", "b", "c"]
        adapter.set(arr)
        
        XCTAssertEqual(adapter.numberOfSections(in: tableView), 1)
        XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: 0), arr.count)
        
    }
    
    func testCellForRow() {
        let arr = ["d", "e", "f", "g"]
        adapter.set(arr)
        
        let testRowIndex = arr.count / 2
        let cell = adapter.tableView(tableView, cellForRowAt: IndexPath(row: testRowIndex, section: 0))
        XCTAssertEqual(cell.textLabel?.text, arr[testRowIndex])
    
        adapter.set([] as! [AnyRow])
        XCTAssertEqual(adapter.numberOfSections(in: tableView), 1)
    }
    
    func testAdapterSetSections() {
        let sections = [Section("A", ["a", "b"]), Section("B", ["d", "e", "f"])]
        
        adapter.set(sections)
        XCTAssertEqual(adapter.numberOfSections(in: tableView), sections.count)
        
        for (i, section) in sections.enumerated() {
            XCTAssertEqual(adapter.tableView(tableView, numberOfRowsInSection: i), sections[i].rows.count)
            
            XCTAssertEqual(adapter.tableView(tableView, titleForHeaderInSection: i), sections[i].header)
            XCTAssertNil(adapter.tableView(tableView, titleForFooterInSection: i))
            
            let testRowIndex = section.rows.count / 2
            let cell = adapter.tableView(tableView, cellForRowAt: IndexPath(row: testRowIndex, section: i))
            XCTAssertEqual(cell.textLabel?.text, section.rows[testRowIndex] as? String)
        }
    }
    
    func testSelectableRow() {
        var callMeCalled = false
        func callMe() {
            callMeCalled = true
        }
        
        adapter.set([SelectableRow("a", callMe())])
        
        XCTAssertFalse(callMeCalled)
        
        adapter.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(callMeCalled)
    }
    
    func testDefaultRowHeight() {
        adapter.set(["a"])
        
        XCTAssertEqual(adapter.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0)), UITableViewAutomaticDimension)
    }
}
