//
//  MainFlowInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation
import CoreLocation
import RxSwift

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
    }
    
    enum Location {
        struct RequestCurrent {}
        
        struct ResponseCurrent {
            let latitude: CLLocationDegrees
            let longitude: CLLocationDegrees
        }
        
        struct RequestEndTracking {}
        struct ResponseEndTracking {}
        
        struct RequestStartTracking {
            var model: MoveEntry
        }
    }
    
    enum History {
        
        struct Request {
            let moveEntry: MoveEntry
        }
        
        struct PathListViewModel {
            let coordinates: CLLocationCoordinate2D
        }
        
        struct ViewModel {
            let pathList: [PathListViewModel]
        }
    }
}

protocol MainFlowDataSource {
    var trackingState: MainFlowViewModel.Tracking.State { get set }
    var moveEntryModel: MoveEntry? { get set }
    var trackPathHistory: [CLLocationCoordinate2D] { get set }
}

protocol MainFlowLogicProtocol {
    func request(_ request: MainFlowViewModel.Location.RequestCurrent)
    func request(_ request: MainFlowViewModel.Location.RequestStartTracking)
    func request(_ request: MainFlowViewModel.Location.RequestEndTracking)
    func request(_ request: MainFlowViewModel.History.Request)
}

class MainFlowInteractor: MainFlowLogicProtocol, MainFlowDataSource {
    weak var locationService: LocationService?
    var presenter: MainFlowPresenterProtocol?
    
    internal var trackingState: MainFlowViewModel.Tracking.State = .off
    internal var moveEntryModel: MoveEntry?
    internal var trackPathHistory: [CLLocationCoordinate2D] = []
    
    internal var subscription: Disposable?
    
    init(locationService: LocationService) {
        self.locationService = locationService
        configureLocationObserver()
    }
    
    deinit {
        subscription?.dispose()
    }
    
    private func configureLocationObserver() {
        subscription = self.locationService?.location.subscribe(onNext: { [weak self] coordinates in
            guard let coordinates = coordinates else { return }
            self?.locationDidUpdated(coordinates)
        }, onError: { error in
            print(error.localizedDescription)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("desposed")
        })
    }
    
    
    func request(_ request: MainFlowViewModel.Location.RequestCurrent) {
        
        guard let locationService = locationService else { return }
        
        locationService.locationManager.requestLocation()
    }
    
    func request(_ request: MainFlowViewModel.Location.RequestEndTracking) {
        // остановить запись трекинга и записать результат в рилм
        guard let locationService = locationService else { return }
        
        trackingState = .off
        
        locationService.locationManager.stopUpdatingLocation()
        
        if let moveEntryModel = moveEntryModel {
            
            try! RealmManager.shared.db.write {
                moveEntryModel.endAt = Date()
                RealmManager.shared.db.add(moveEntryModel, update: .modified)
            }
            
            self.moveEntryModel = nil
        }
        
        presenter?.present(response: MainFlowViewModel.Location.ResponseEndTracking())
    }
    
    func request(_ request: MainFlowViewModel.Location.RequestStartTracking) {
        
        guard let locationService = locationService else { return }
        
        moveEntryModel = request.model
        
        // начать запись перемещений
        trackingState = .on
        locationService.locationManager.requestLocation()
        locationService.locationManager.startUpdatingLocation()
        locationService.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func request(_ request: MainFlowViewModel.History.Request) {
        presenter?.present(
            response: MainFlowViewModel.History.ViewModel(
                pathList: request.moveEntry.pathList.map({ path in
                    return MainFlowViewModel.History.PathListViewModel(
                        coordinates: CLLocationCoordinate2D(
                            latitude: CLLocationDegrees(path.latitude),
                            longitude: CLLocationDegrees(path.longitude)
                        )
                    )
                })
            )
        )
    }

    private func locationDidUpdated(_ coodrinates: CLLocationCoordinate2D) {
        
        if trackingState == .on {
            
            try! RealmManager.shared.db.write({
                moveEntryModel?.pathList.append(
                    MoveEntryPath(
                        latitude: Double(coodrinates.latitude),
                        longitude: Double(coodrinates.longitude),
                        date: Date()
                    )
                )
            })
        }
        
        presenter?.present(
            response: MainFlowViewModel.Location.ResponseCurrent(
                latitude: coodrinates.latitude,
                longitude: coodrinates.longitude
            )
        )
    }
}
