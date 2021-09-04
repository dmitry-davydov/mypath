//
//  AuthCoordinator.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    override func start() {
        showSignIn()
    }
    
    func showSignIn() {
        let controller = AuthFlowFactory().construct()
        
        controller.onRememberPassword = { [weak self] in
            let coordinator = ResetPasswordCoordinator()
            
            coordinator.onFinishFlow = { [weak self] in
                self?.removeDependency(coordinator)
                
                self?.start()
            }
            
            self?.addDependency(coordinator)
            
            coordinator.start()
            
        }
        controller.onSignIn = { [weak self] in
            let coordinator = TrackingListCoordinator()
            self?.addDependency(coordinator)
            coordinator.start()
        }
        
        controller.onSignUp = { [weak self] in
            let coordinator = SignUpCoordinator()
            self?.addDependency(coordinator)
            
            coordinator.onFinishFlow = { [weak self] in
                self?.removeDependency(coordinator)
                
                self?.start()
            }
            
            coordinator.start()
        }
        
        setAsRoot(controller)
    }
}
