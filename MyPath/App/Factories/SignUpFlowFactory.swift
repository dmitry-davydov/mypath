//
//  SignUpFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol SignUpFlowFactoryProtocol {
    func construct() -> SignUpViewController
}

class SignUpFlowFactory: SignUpFlowFactoryProtocol {
    func construct() -> SignUpViewController {
        let viewController = SignUpViewController()
        let presenter = SignUpPresenter()
        
        presenter.viewController = viewController
        
        let interactor = SignUpInteractor(service: AuthService.shared)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
        return viewController
    }
}
