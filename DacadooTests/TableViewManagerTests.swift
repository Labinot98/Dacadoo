//
//  TableViewManagerTests.swift
//  TableViewManagerTests
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import XCTest
@testable import Dacadoo

class MockCell: UITableViewCell {
    var item: String?
}

class TableViewManagerTests: XCTestCase {

    var tableView: UITableView!
    var items: [String]!
    var sut: TableViewManager<String, MockCell>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tableView = UITableView()
        tableView.register(MockCell.self, forCellReuseIdentifier: String(describing: MockCell.self))
        items = ["Item 1", "Item 2", "Item 3"]
        sut = TableViewManager<String, MockCell>(items: items, configureCell: { (cell, item) in
            cell.item = item
        }, didSelectItem: { item in
            print("Selected item: \(item)")
        })
        tableView.delegate = sut
        tableView.dataSource = sut
    }

    override func tearDownWithError() throws {
        tableView = nil
        items = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testNumberOfSections() {
        let numberOfSections = sut.numberOfSections(in: tableView)
        XCTAssertEqual(numberOfSections, 1)
    }

    func testNumberOfRows() {
        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, items.count)
    }

    func testCellForRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath) as! MockCell
        XCTAssertEqual(cell.item, items[indexPath.row])
    }

    func testDidSelectRow() {
        let expectation = self.expectation(description: "DidSelectItem called")
        sut.didSelectItem = { item in
            XCTAssertEqual(item, self.items[0])
            expectation.fulfill()
        }
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(tableView, didSelectRowAt: indexPath)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
