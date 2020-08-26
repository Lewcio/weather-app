//
//  LocationManager.swift
//  Weather
//
//  Created by m.lewandowski on 26/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var getCurrentLocation: Location? { get }
}

class LocationManager: LocationManagerProtocol {
    
    var getCurrentLocation: Location? {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let location = locationManager.location
        
        guard let latitude = location?.coordinate.latitude,
            let longitude = location?.coordinate.longitude
            else { return nil }
        
        return Location(latitude: latitude, longitude: longitude)
    }
}
