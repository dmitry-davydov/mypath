//
//  LocationService.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

class LocationService: NSObject {
    static var shared = LocationService()
    
    let locationManager: CLLocationManager = CLLocationManager()

    let location: BehaviorRelay<CLLocationCoordinate2D?> = BehaviorRelay(value: nil)
    
    override private init() {
        super.init()
        
        configure()
    }
    
    private func configure() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.delegate = self
    }
}

// MARK: - CLLocationManagerDelegat
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        location.accept(lastLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
