//
//  Location.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?

    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {

        self.name = name
        self.coordinate = coordinate
    }
}
