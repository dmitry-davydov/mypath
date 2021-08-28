//
//  TrackingListFlowPresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

protocol TrackingListFlowPresenterProtocol {
    func present(_ response: TrackingListModel.MoveEntries.Response)
    func present(_ response: TrackingListModel.Track.ResponseHistory)
    func present(_ response: TrackingListModel.Track.ResponseNewTrack)
}

class TrackingListFlowPresenter: TrackingListFlowPresenterProtocol {
    
    weak var viewController: TrackingListFlowDisplayLogic?
    
    func present(_ response: TrackingListModel.MoveEntries.Response) {
        viewController?.display(TrackingListModel.MoveEntries.Response(items: response.items))
    }
    
    func present(_ response: TrackingListModel.Track.ResponseHistory) {
        viewController?.display(TrackingListModel.ViewModel.ViewModelHistory(item: MainViewController.State.view(response.item)))
    }
    
    func present(_ response: TrackingListModel.Track.ResponseNewTrack) {
        viewController?.display(TrackingListModel.ViewModel.ViewModelNewTrack(item: MainViewController.State.tracking(response.item)))
    }
}
