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
    func display(viewModel: MainFlowViewModel.UserImage.ViewModel)
}

class MainView: UIView {
    private var mapView = GMSMapView(frame: .zero)
    private var route = GMSPolyline()
    private var routePath = GMSMutablePath()
    private var marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
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
        marker.map = mapView
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
    
    func display(viewModel: MainFlowViewModel.UserImage.ViewModel) {
        let imageView = UIImageView(image: viewModel.image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        marker.iconView = imageView
        
    }
    
    func display(viewModel: MainFlowViewModel.Location.ResponseCurrent) {
        let cameraPosition = GMSCameraPosition(
            latitude: viewModel.latitude,
            longitude: viewModel.longitude,
            zoom: 17
        )

        mapView.animate(to: cameraPosition)

        let coordinates = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        routePath.add(coordinates)
        route.path = routePath
        marker.position = coordinates
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
