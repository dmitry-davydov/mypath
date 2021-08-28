//
//  SignUpCoordinator.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

class SignUpCoordinator: BaseCoordinator {
    
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        let controller = SignUpFlowFactory().construct()
        
        controller.onEndFlow = { [weak self] in
            self?.onFinishFlow?()
        }
        
        setAsRoot(controller)
    }
}
