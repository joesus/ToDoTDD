//
//  ItemCellTests.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

@testable import ToDoTDD
import XCTest

class ItemCellTests: XCTestCase {

    let dataSource = FakeDataSource()
    var controller: ItemListViewController!
    var tableView: UITableView!
    var cell: ItemCell!

    override func setUp() {
        super.setUp()

        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ItemListViewController else {
            return XCTFail("Main storyboard should have an ItemListViewController")
        }

        controller = vc
        controller.loadViewIfNeeded()

        tableView = controller.tableView
        tableView.dataSource = dataSource

        cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as? ItemCell // The fake dataSource allows us to get a single cell without worrying about dependencies like itemManager etc...
    }

    func testHasNameLabel() {
        XCTAssertNotNil(cell?.titleLabel)
    }

    func testHasLocationLabel() {
        XCTAssertNotNil(cell?.locationLabel)
    }

    func testHasDateLabel() {
        XCTAssertNotNil(cell?.dateLabel)
    }

    func testConfigCellSetsLabelTexts() {
        cell.configCell(with: ToDoItem(title: "Foo",
                                       itemDescription: nil,
                                       timestamp: 1456150025,
                                       location: Location(name: "Bar")))

        XCTAssertEqual(cell.titleLabel.text, "Foo")
        XCTAssertEqual(cell.locationLabel.text, "Bar")
        XCTAssertEqual(cell.dateLabel.text,  "02/22/2016")
    }

    func testTitleWhenItemIsChecked() {
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo",
                            itemDescription: nil,
                            timestamp: 1456150025,
                            location: location)

        cell.configCell(with: item, checked: true)

        let attributedString = NSAttributedString(string: "Foo",
                                                  attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])

        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
