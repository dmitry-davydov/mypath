//
//  ResetpasswordFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol ResetPasswordFlowFactoryProtocol {
    func construct() -> ResetPasswordViewController
}

class ResetPasswordFlowFactory: ResetPasswordFlowFactoryProtocol {
    func construct() -> ResetPasswordViewController {
        let viewController = ResetPasswordViewController()
        let presenter = ResetPasswordPresenter()
        
        presenter.viewController = viewController
        
        let interactor = ResetPasswordInteractor(service: AuthService.shared)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        
        return viewController
    }
}
