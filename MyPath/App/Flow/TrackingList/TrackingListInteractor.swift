//
//  TrackingListInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

protocol TrackingFlowLogicProtocol {
    func request(_ request: TrackingListModel.MoveEntries.Request)
    func request(_ request: TrackingListModel.Track.RequestNewTrack)
    func request(_ request: TrackingListModel.Track.RequestHistory)
}

protocol TrackingFlowDisplayLogicProtocol {
    func present(_ response: TrackingListModel.MoveEntries.Response)
    func present(_ response: TrackingListModel.Track.ResponseHistory)
    func present(_ response: TrackingListModel.Track.ResponseNewTrack)
}

class TrackingListInteractor: TrackingFlowLogicProtocol {
    
    var presenter: TrackingListFlowPresenterProtocol?
    
    // MARK: - TrackingFlowLogicProtocol
    func request(_ request: TrackingListModel.MoveEntries.Request) {
        // забрать из бд данные
        
        let moveEntries = RealmManager.shared.db.objects(MoveEntry.self).sorted(byKeyPath: "startAt", ascending: false)
        
        // отправить в пресентер
        presenter?.present(TrackingListModel.MoveEntries.Response(items: moveEntries.map({$0})))
    }
    
    func request(_ request: TrackingListModel.Track.RequestNewTrack) {
        let newMoveEntry = MoveEntry(startAt: Date())
        
        // создать новую запась в БД
        try! RealmManager.shared.db.write({
            RealmManager.shared.db.add(newMoveEntry)
        })
        
        presenter?.present(TrackingListModel.Track.ResponseNewTrack(item: newMoveEntry))
    }
    
    func request(_ request: TrackingListModel.Track.RequestHistory) {
        presenter?.present(TrackingListModel.Track.ResponseHistory(item: request.item))
    }
}
