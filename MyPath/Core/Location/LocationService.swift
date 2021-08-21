//
//  LocationService.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    static var shared = LocationService()
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override private init() {
        super.init()
        
        configure()
    }
    
    private func configure() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        NotificationCenter.default.post(
            name: Notification.Name.Location.DidUpdated,
            object: nil,
            userInfo: [
                "lat": lastLocation.coordinate.latitude,
                "lon": lastLocation.coordinate.longitude
            ]
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
