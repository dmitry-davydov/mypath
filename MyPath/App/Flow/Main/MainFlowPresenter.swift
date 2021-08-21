//
//  MainFlowPResenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit

protocol MainFlowPresenterProtocol {
    func present(response: MainFlowViewModel.Location.ResponseCurrent)
    func present(response: MainFlowViewModel.Tracking.State)
}

class MainFlowPresenter: MainFlowPresenterProtocol {
    
    weak var viewController: MainFlowDisplayLogic?
    
    func present(response: MainFlowViewModel.Location.ResponseCurrent) {
        viewController?.display(request: response)
    }
    
    func present(response: MainFlowViewModel.Tracking.State) {
        viewController?.display(request: response)
    }
}
