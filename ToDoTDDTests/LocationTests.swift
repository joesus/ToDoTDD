//
//  LocationTests.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest
import CoreLocation

class LocationTests: XCTestCase {

    func testInitWithCoordinateSetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1,
                                                longitude: 2)

        let location = Location(name: "", coordinate: coordinate)

        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude,
                       "Should set correct latitude on location")
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude,
                       "Should set correct longitude on location")
    }

    func testEqualLocationsAreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")

        XCTAssertEqual(first, second)
    }

    func testLocationEqualityDifferentLatitudes() {
        performNotEqualTestWith(firstName: "Foo",
                                secondName: "Foo",
                                firstLatLong: (1.0, 0.0),
                                secondLatLong: (0.0, 0.0)
        )
    }

    func testLocationNotEqualWhenOnlyOneHasCoordinate() {
        performNotEqualTestWith(firstName: "Foo",
                                secondName: "Foo",
                                firstLatLong: (0.0, 0.0),
                                secondLatLong: nil
        )
    }

    func testLocationNotEqualWhenNamesDifferent() {
        performNotEqualTestWith(firstName: "Foo",
                                secondName: "Bar",
                                firstLatLong: nil,
                                secondLatLong: nil
        )
    }

}

extension LocationTests {
    func performNotEqualTestWith(firstName: String,
                                 secondName: String,
                                 firstLatLong: (Double, Double)?,
                                 secondLatLong: (Double, Double)?,
                                 _ file: StaticString = #file,
                                 _ line: UInt = #line) {

        var firstCoord: CLLocationCoordinate2D?
        if let firstLatLong = firstLatLong {
            firstCoord = CLLocationCoordinate2D(latitude: firstLatLong.0, longitude: firstLatLong.1)
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)

        var secondCoord: CLLocationCoordinate2D?
        if let secondLatLong = secondLatLong {
            secondCoord = CLLocationCoordinate2D(latitude: secondLatLong.0, longitude: secondLatLong.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)

        XCTAssertNotEqual(firstLocation, secondLocation, file: file, line: line)
    }
}
