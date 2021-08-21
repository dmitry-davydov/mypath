//
//  MainFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation


protocol MainFlowFactoryProtocol {
    func construct() -> MainViewController
}

class MainFlowFactory: MainFlowFactoryProtocol {
    
    func construct() -> MainViewController {
        
        let mainFlowViewController = MainViewController()
        let presenter = MainFlowPresenter()
        presenter.viewController = mainFlowViewController
        
        
        let interactor = MainFlowInteractor(locationService: LocationService.shared)
        interactor.presenter = presenter
        
        
        mainFlowViewController.interactor = interactor
        
        return mainFlowViewController
    }
}
