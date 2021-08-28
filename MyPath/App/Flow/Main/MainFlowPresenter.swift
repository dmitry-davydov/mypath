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
    func present(response: MainFlowViewModel.Location.ResponseEndTracking)
    func present(response: MainFlowViewModel.History.ViewModel)
}

class MainFlowPresenter: MainFlowPresenterProtocol {
    
    weak var viewController: MainFlowDisplayLogic?
    
    func present(response: MainFlowViewModel.Location.ResponseCurrent) {
        viewController?.display(viewModel: response)
    }
    
    func present(response: MainFlowViewModel.Tracking.State) {
        viewController?.display(viewModel: response)
    }
    
    func present(response: MainFlowViewModel.Location.ResponseEndTracking) {
        viewController?.displayPreviouseScreen()
    }
    
    func present(response: MainFlowViewModel.History.ViewModel) {
        viewController?.display(viewModel: response)
    }
}
