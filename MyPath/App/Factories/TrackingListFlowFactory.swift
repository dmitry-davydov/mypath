//
//  TrackingListFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

protocol TrackingListFlowFactoryProtocol {
    func construct() -> TrackingListViewController
}


class TrackingListFlowFactory: TrackingListFlowFactoryProtocol {
    func construct() -> TrackingListViewController {
        let viewController = TrackingListViewController()
        let presenter = TrackingListFlowPresenter()
        presenter.viewController = viewController
        
        
        let interactor = TrackingListInteractor()
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
        return viewController
    }
}
