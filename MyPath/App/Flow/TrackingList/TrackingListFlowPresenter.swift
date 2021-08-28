//
//  TrackingListFlowPresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

protocol TrackingListFlowPresenterProtocol {
    func present(_ response: TrackingListModel.MoveEntries.Response)
    func present(_ request: UIViewController)
}

class TrackingListFlowPresenter: TrackingListFlowPresenterProtocol {
    
    weak var viewController: (UIViewController & TrackingListFlowDisplayLogic)?
    
    func present(_ response: TrackingListModel.MoveEntries.Response) {
        viewController?.display(response)
    }
    
    func present(_ request: UIViewController) {
        viewController?.display(request)
    }
}
