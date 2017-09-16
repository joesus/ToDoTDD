//
//  DetailViewControllerTests.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest
import CoreLocation

class DetailViewControllerTests: XCTestCase {

    var controller: DetailViewController!
    let itemManager = ItemManager()

    override func setUp() {
        super.setUp()

        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return XCTFail("Main storyboard should have a detail view controller")
        }
        controller = vc
        controller.loadViewIfNeeded()
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(controller.titleLabel)
    }

    func testHasLocationLabel() {
        XCTAssertNotNil(controller.locationLabel)
    }

    func testHasDateLabel() {
        XCTAssertNotNil(controller.dateLabel)
    }

    func testHasDescriptionLabel() {
        XCTAssertNotNil(controller.descriptionLabel)
    }

    func testHasMapView() {
        XCTAssertNotNil(controller.mapView)
    }

    func testSettingItemInfoSetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)

        let item = ToDoItem(title: "Bar",
                            itemDescription: "Baz",
                            timestamp: 1456150025,
                            location: location)

        itemManager.add(item)

        controller.itemInfo = (itemManager, 0)

        // Calling begin and end transition methods trigger the calls to viewWillAppear and viewDidAppear
        controller.beginAppearanceTransition(true, animated: true)
        controller.endAppearanceTransition()

        XCTAssertEqual(controller.titleLabel.text, "Bar")
        XCTAssertEqual(controller.dateLabel.text, "02/22/2016")
        XCTAssertEqual(controller.locationLabel.text, "Foo")
        XCTAssertEqual(controller.descriptionLabel.text, "Baz")

        XCTAssertEqualWithAccuracy(controller.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(controller.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
    }

    func testCheckItemChecksItemInManager() {
        itemManager.add(ToDoItem(title: "Foo"))

        controller.itemInfo = (itemManager, 0)

        controller.checkItem()

        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}




