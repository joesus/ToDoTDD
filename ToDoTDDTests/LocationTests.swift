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

}
