//
//  Location.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?

    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {

        self.name = name
        self.coordinate = coordinate
    }
}

func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.coordinate?.latitude != rhs.coordinate?.latitude ||
        lhs.coordinate?.longitude != rhs.coordinate?.longitude ||
        lhs.name != rhs.name {

        return false
    }
    return true
}
