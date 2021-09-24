//
//  MainFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import Foundation


protocol MainFlowFactoryProtocol {
    func construct(state: MainViewController.State) -> MainViewController
}

class MainFlowFactory: MainFlowFactoryProtocol {
    
    func construct(state: MainViewController.State) -> MainViewController {
        
        let mainFlowViewController = MainViewController(state: state)
        let presenter = MainFlowPresenter()
        presenter.viewController = mainFlowViewController
        
        
        let interactor = MainFlowInteractor(locationService: LocationService.shared, fileStorage: FileStorage.shared)
        interactor.presenter = presenter
        
        
        mainFlowViewController.interactor = interactor
        
        return mainFlowViewController
    }
}
