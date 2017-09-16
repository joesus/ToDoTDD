//
//  ItemListViewControllerTests.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest

class ItemListViewControllerTests: XCTestCase {

    var controller: ItemListViewController!

    override func setUp() {
        super.setUp()

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ItemListViewController
        controller = vc
        controller.loadViewIfNeeded()
    }
    
    func testTableViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(controller.tableView)
    }

    func testLoadingViewSetsTableViewDataSource() {
        XCTAssertTrue(controller.tableView?.dataSource is ItemListDataProvider)
    }

    func testLoadingViewSetsTableViewDelegate() {
        XCTAssertTrue(controller.tableView.delegate is ItemListDataProvider)
    }

    func testLoadingViewSetsDataSourceAndDelegateToSameobject() {
        XCTAssertEqual(controller.tableView.dataSource as? ItemListDataProvider,
                       controller.tableView.delegate as? ItemListDataProvider)
    }
}
