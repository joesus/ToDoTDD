//
//  ItemListDataProviderTests.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest

class ItemListDataProviderTests: XCTestCase {

    let firstIndexPath = IndexPath(row: 0, section: 0)
    let dataProvider = ItemListDataProvider()
    var tableView = UITableView()
    var itemManager: ItemManager!

    override func setUp() {
        super.setUp()

        itemManager = ItemManager()
        dataProvider.itemManager = itemManager

        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ItemListViewController
        controller.loadViewIfNeeded()
        tableView = controller.tableView
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(tableView.numberOfSections, 2)
    }

    func testNumberOfRowsInFirstSectionIsToDoCount() {
        dataProvider.itemManager?.add(ToDoItem(title: "Foo"))

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)

        itemManager?.add(ToDoItem(title: "Bar"))

        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }

    func testNumberOfRowsInSecondSectionIsDoneCount() {
        itemManager.add(ToDoItem(title: "Foo"))
        itemManager.add(ToDoItem(title: "Bar"))

        itemManager.checkItem(at: 0)

        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)

        itemManager.checkItem(at: 0)

        tableView.reloadData() // because it caches the first call to numberOfRows

        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }

    func testCellForRowIsItemCell() {
        itemManager.add(ToDoItem(title: "Foo"))
        tableView.reloadData()

        guard let _ = dataProvider.tableView(tableView, cellForRowAt: firstIndexPath) as? ItemCell else {
            return XCTFail("Cell for row should return an ItemCell")
        }
    }

    func testCellForRowDequeuesFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)

        itemManager.add(ToDoItem(title: "Foo"))

        mockTableView.reloadData()

        _ = mockTableView.cellForRow(at: firstIndexPath)

        XCTAssertTrue(mockTableView.cellGotDequeued)
    }

    func testCellForRowCallsConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)

        let item = ToDoItem(title: "Foo")
        itemManager.add(item)

        mockTableView.reloadData()

        let cell = mockTableView.cellForRow(at: firstIndexPath) as! MockItemCell

        XCTAssertTrue(cell.configCellGotCalled)
        XCTAssertEqual(cell.capturedToDoItem, item)
    }

    func testCellForRowInSecondSectionCallConfigWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)

        let item = ToDoItem(title: "Foo")
        itemManager.add(item)

        let second = ToDoItem(title: "Bar")
        itemManager.add(second)
        itemManager.checkItem(at: 1)

        mockTableView.reloadData()

        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell

        XCTAssertEqual(cell.capturedToDoItem, second)
    }

    func testDeletebuttonInFirstSectionTitle() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: firstIndexPath)

        XCTAssertEqual(deleteButtonTitle, "Check")
    }

    func testDeleteButtonInSecondSectionTitle() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))

        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }

    func testCheckingAnItemUpdatesItemInManager() {
        itemManager.add(ToDoItem(title: "Foo"))

        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: firstIndexPath)

        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }

    func testUncheckingAnItemUpdatesItemInManager() {
        itemManager.add(ToDoItem(title: "Foo"))
        itemManager.checkItem(at: 0)
        tableView.reloadData()

        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))

        XCTAssertEqual(itemManager.toDoCount, 1)
        XCTAssertEqual(itemManager.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
}

extension ItemListDataProviderTests {
    class MockTableView: UITableView {
        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 500)) // The frame overrides an optimization that renders the second section unavailable
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")

            return mockTableView
        }

        var cellGotDequeued = false

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true

            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }

    class MockItemCell: ItemCell {
        var configCellGotCalled = false
        var capturedToDoItem: ToDoItem?

        override func configCell(with item: ToDoItem, checked: Bool = false) {
            configCellGotCalled = true
            capturedToDoItem = item
        }
    }
}
