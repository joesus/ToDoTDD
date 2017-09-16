//
//  DetailViewController.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    var itemInfo: (ItemManager, Int)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let manager = itemInfo?.0,
            let itemIndex = itemInfo?.1 else {
                return
        }

        let item = manager.item(at: itemIndex)

        titleLabel.text = item.title
        descriptionLabel.text = item.itemDescription
        locationLabel.text = item.location?.name

        if let timestamp = item.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = Date.dateFormatter.string(from: date)
        }

        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            mapView.region = region
        }
    }

    func checkItem() {
        if let manager = itemInfo?.0,
            let itemIndex = itemInfo?.1 {

            manager.checkItem(at: itemIndex)
        }
    }
}
