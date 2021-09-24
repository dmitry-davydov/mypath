//
//  TrackingListCoordinator.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit

final class TrackingListCoordinator: BaseCoordinator {
    
    override func start() {
        let controller = TrackingListFlowFactory().construct()
        let navigationViewController = UINavigationController(rootViewController: controller)
        
        controller.onSelect = { [weak self, unowned navigationViewController] state in
            self?.showMap(state: state, rootController: navigationViewController)
        }
        
        controller.onNewTracking = { [weak self, unowned navigationViewController] state in
            self?.showMap(state: state, rootController: navigationViewController)
        }
        
        controller.onProfile = { [weak self, unowned navigationViewController] in
            self?.showProfile(rootController: navigationViewController)
        }
        
        setAsRoot(navigationViewController)
    }
    
    private func showProfile(rootController: UINavigationController) {
        let controller = ProfileFlowFactory().construct()
        rootController.pushViewController(controller, animated: true)
    }
    
    private func showMap(state: MainViewController.State, rootController: UINavigationController) {
        let controller = MainFlowFactory().construct(state: state)
        rootController.pushViewController(controller, animated: true)
    }
}
