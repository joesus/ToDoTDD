//
//  ToDoItemTests.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest

class ToDoItemTests: XCTestCase {

    func testInitWithTitleSetsTitle() {
        let item = ToDoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo",
                       "Initializer should set title")
    }

    func testInitWithDescriptionSetsDescription() {
        let item = ToDoItem(title: "Foo", itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar",
                       "Initializer should set itemDescription")
    }

    func testInitWithTimeStampSetsTimeStamp() {
        let item = ToDoItem(title: "", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0,
                       "Initializer should set timestamp")
    }

    func testInitWithLocationSetsLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "", location: location)

        XCTAssertEqual(item.location?.name, location.name,
                       "Initializer should set location")
    }
    
}
