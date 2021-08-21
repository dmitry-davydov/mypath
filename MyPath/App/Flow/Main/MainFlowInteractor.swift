//
//  MainFlowInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation
import CoreLocation

enum MainFlowViewModel {
    enum Tracking {
        
        enum State {
            case on
            case off
            
            mutating func toggle() {
                switch self {
                case .on:
                    self = .off
                case .off:
                    self = .on
                }
            }
        }
        
        struct Toggle {}
    }
    
    enum Location {
        struct RequestCurrent {}
        
        struct ResponseCurrent {
            let latitude: CLLocationDegrees
            let longitude: CLLocationDegrees
        }
    }
}

protocol MainFlowDataSource {
    var trackingState: MainFlowViewModel.Tracking.State { get set }
}

protocol MainFlowLogicProtocol {
    func request(_ request: MainFlowViewModel.Location.RequestCurrent)
    func request(_ request: MainFlowViewModel.Tracking.Toggle)
    
}

class MainFlowInteractor: MainFlowLogicProtocol, MainFlowDataSource {

    weak var locationService: LocationService?
    var presenter: MainFlowPresenterProtocol?
    
    internal var trackingState: MainFlowViewModel.Tracking.State = .off
    
    init(locationService: LocationService) {
        self.locationService = locationService
        
        NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdated), name: Notification.Name.Location.DidUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func request(_ request: MainFlowViewModel.Location.RequestCurrent) {
        
        guard let locationService = locationService else { return }
        
        locationService.locationManager.requestLocation()
    }
    
    func request(_ request: MainFlowViewModel.Tracking.Toggle) {
        
        guard let locationService = locationService else { return }
        
        trackingState.toggle()
        
        presenter?.present(response: trackingState)
        
        switch trackingState {
        case .on:
            locationService.locationManager.requestLocation()
            locationService.locationManager.startUpdatingLocation()
        case .off:
            locationService.locationManager.stopUpdatingLocation()
        }
    }
    
    //MARK: - NotificationCenter Observers
    @objc private func locationDidUpdated(_ notification: NSNotification) {
        
        guard let lat = notification.userInfo?["lat"] as? CLLocationDegrees,
              let lon = notification.userInfo?["lon"] as? CLLocationDegrees else { return }
        
        presenter?.present(
            response: MainFlowViewModel.Location.ResponseCurrent(
                latitude: lat,
                longitude: lon
            )
        )
    }
}
