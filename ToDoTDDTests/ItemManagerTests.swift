//
//  ItemManagerTests.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest

class ItemManagerTests: XCTestCase {

    var manager: ItemManager!

    override func setUp() {
        super.setUp()

        manager = ItemManager()
    }

    func testToDoCountZeroByDefault() {
        XCTAssertEqual(manager.toDoCount, 0,
                       "Item manager should have zero todos by default")
    }

    func testDoneCountZeroByDefault() {
        XCTAssertEqual(manager.doneCount, 0,
                       "Item manager should have zero done todos by default")
    }

    func testAddingItemIncreasesToDoCount() {
        manager.add(ToDoItem(title: ""))

        XCTAssertEqual(manager.toDoCount, 1,
                       "Adding a single item should increase the count by one")
    }

    func testItemAtAfterAddingItemReturnsThatItem() {
        let item = ToDoItem(title: "Foo")

        manager.add(item)

        let returnedItem = manager.item(at: 0)

        XCTAssertEqual(returnedItem.title, item.title)
    }

    func testCheckItemAtChangesCount() {
        manager.add(ToDoItem(title: ""))

        manager.checkItem(at: 0)

        XCTAssertEqual(manager.toDoCount, 0,
                       "Checking item should decrease todo count by one")
        XCTAssertEqual(manager.doneCount, 1,
                       "Checking item should increase done count by one")
    }

    func testCheckItemRemovesItFromToDoItems() {
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")

        manager.add(first)
        manager.add(second)

        manager.checkItem(at: 0)

        XCTAssertEqual(manager.item(at: 0).title, second.title,
                       "Checking item at first index should remove item at first index")
    }

    func testDoneItemAtReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        manager.add(item)

        manager.checkItem(at: 0)

        let returnedItem = manager.doneItem(at: 0)

        XCTAssertEqual(returnedItem.title, item.title)
    }
}
