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
    func display(viewModel: MainFlowViewModel.Location.ResponseCurrent)
    func display(viewModel: MainFlowViewModel.History.ViewModel)
}

class MainView: UIView {
    private var mapView = GMSMapView(frame: .zero)
    private var route = GMSPolyline()
    private var routePath = GMSMutablePath()
    
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
        
        route.map = mapView
        
        layout()
        
        route.strokeWidth = 4
    }
    
    
    private func layout() {
        mapView.snp.makeConstraints({make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        })
    }
}

extension MainView: MainFlowViewLogic {
    
    func display(viewModel: MainFlowViewModel.Location.ResponseCurrent) {
        let cameraPosition = GMSCameraPosition(
            latitude: viewModel.latitude,
            longitude: viewModel.longitude,
            zoom: 17
        )

        mapView.animate(to: cameraPosition)

        routePath.add(CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude))
        route.path = routePath
    }
    
    func display(viewModel: MainFlowViewModel.History.ViewModel) {
        
        if let firstCoordinated = viewModel.pathList.first?.coordinates,
           let lastCoordinated = viewModel.pathList.last?.coordinates {

            let cameraBounds = GMSCoordinateBounds(
                
                coordinate: lastCoordinated,
                coordinate: firstCoordinated
            )
            
            let update = GMSCameraUpdate.fit(cameraBounds, withPadding: 50.0)
            mapView.moveCamera(update)

        } else {
            // взять середину массива
            
            let middleItemIndex = Int(viewModel.pathList.count / 2)
            let middleItem = viewModel.pathList[middleItemIndex]
            
            // оцентрировать по ней карту
            // и выставить зум камеры
            let cameraPosition = GMSCameraPosition(
                latitude: middleItem.coordinates.latitude,
                longitude: middleItem.coordinates.longitude,
                zoom: 7
            )
            mapView.animate(to: cameraPosition)
        }
        
        viewModel.pathList.forEach { vm in
            routePath.add(CLLocationCoordinate2D(latitude: vm.coordinates.latitude, longitude: vm.coordinates.longitude))
        }
        
        route.path = routePath
    }
}
