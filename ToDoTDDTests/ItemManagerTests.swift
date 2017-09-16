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

        XCTAssertEqual(returnedItem, item)
    }

    func testCheckItemAtChangesCount() {
        manager.add(ToDoItem(title: ""))

        manager.checkItem(at: 0)

        XCTAssertEqual(manager.toDoCount, 0,
                       "Checking item should decrease todo count by one")
        XCTAssertEqual(manager.doneCount, 1,
                       "Checking item should increase done count by one")
    }

    func testUncheckItemAtChangesCount() {
        manager.add(ToDoItem(title: ""))

        manager.checkItem(at: 0)
        manager.uncheckItem(at: 0)

        XCTAssertEqual(manager.toDoCount, 1,
                       "Unchecking item should add it back to todos")
        XCTAssertEqual(manager.doneCount, 0,
                       "Unchecking item should remove it from todos")
    }

    func testCheckItemRemovesItFromToDoItems() {
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")

        manager.add(first)
        manager.add(second)

        manager.checkItem(at: 0)

        XCTAssertEqual(manager.item(at: 0), second,
                       "Checking item at first index should remove item at first index")
    }

    func testUncheckItemRemovesitFromDoneItems() {
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")

        manager.add(first)
        manager.add(second)

        manager.checkItem(at: 0)
        manager.checkItem(at: 0)

        manager.uncheckItem(at: 0)

        XCTAssertEqual(manager.doneItem(at: 0), second,
                       "Checking item at first index should remove item at first index")
    }

    func testDoneItemAtReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        manager.add(item)

        manager.checkItem(at: 0)

        let returnedItem = manager.doneItem(at: 0)

        XCTAssertEqual(returnedItem, item)
    }

    func testRemoveAllResults() {
        manager.add(ToDoItem(title: "Foo"))
        manager.add(ToDoItem(title: "Bar"))
        manager.checkItem(at: 0)

        XCTAssertEqual(manager.toDoCount, 1)
        XCTAssertEqual(manager.doneCount, 1)

        manager.removeAll()

        XCTAssertEqual(manager.toDoCount, 0)
        XCTAssertEqual(manager.doneCount, 0)
    }

    func testDoesNotAddDuplicateItem() {
        manager.add(ToDoItem(title: "Foo"))
        manager.add(ToDoItem(title: "Foo"))

        XCTAssertEqual(manager.toDoCount, 1)
    }
}
