//
//  AithFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol AuthFlowFactoryProtocol {
    func construct() -> AuthViewController
}

class AuthFlowFactory: AuthFlowFactoryProtocol {
    func construct() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthFlowPresenter()
        
        presenter.viewController = viewController
        
        let interactor = AuthFlowIneractor(service: AuthService.shared)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
        return viewController
    }
}
