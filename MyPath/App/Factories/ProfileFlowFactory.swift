//
//  ProfileFlowFactory.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import UIKit

protocol ProfileFlowFactoryProtocol {
    func construct() -> ProfileViewController
}

class ProfileFlowFactory: ProfileFlowFactoryProtocol {
    func construct() -> ProfileViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        presenter.viewController = viewController
        
        
        let interactor = ProfileInteractor(fileStorage: FileStorage.shared)
        interactor.presenter = presenter
        
        
        viewController.interactor = interactor
        
        return viewController
    }
}
