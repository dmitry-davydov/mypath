//
//  ResetPasswordCoordinator.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

final class ResetPasswordCoordinator: BaseCoordinator {
    
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        let viewController = ResetPasswordFlowFactory().construct()
        
        viewController.onEndFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        
        setAsRoot(viewController)
    }
}
