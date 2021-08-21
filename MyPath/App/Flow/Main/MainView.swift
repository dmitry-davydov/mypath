//
//  View.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit
import GoogleMaps
import SnapKit

protocol MainFlowViewLogic {
    func display(request: MainFlowViewModel.Location.ResponseCurrent)
}

class MainView: UIView {
    private var mapView = GMSMapView(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    private func configureView() {
        addSubview(mapView)
        layout()
    }
    
    
    private func layout() {
        mapView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
    }
}

extension MainView: MainFlowViewLogic {
    
    func display(request: MainFlowViewModel.Location.ResponseCurrent) {
        let cameraPosition = GMSCameraPosition(
            latitude: request.latitude,
            longitude: request.longitude,
            zoom: 17
        )

        mapView.animate(to: cameraPosition)

        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: request.latitude, longitude: request.longitude))
        marker.map = mapView
    }
}
