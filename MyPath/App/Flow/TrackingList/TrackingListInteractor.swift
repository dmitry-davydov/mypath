//
//  TrackingListInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

protocol TrackingFlowLogicProtocol {
    func request(_ request: TrackingListModel.MoveEntries.Request)
    func request(_ request: TrackingListModel.NewMove.Request)
    func request(_ request: TrackingListModel.MoveEntries.HistoryRequest)
}

protocol TrackingFlowDisplayLogicProtocol {
    func present(_ request: TrackingListModel.MoveEntries.Response)
    func present(_ request: UIViewController)
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
    
    func request(_ request: TrackingListModel.NewMove.Request) {
        let newMoveEntry = MoveEntry(startAt: Date())
        
        // создать новую запась в БД
        try! RealmManager.shared.db.write({
            RealmManager.shared.db.add(newMoveEntry)
        })
        
        // передать стейт, что будет производится сразу трекинг
        let mapViewController = MainFlowFactory().construct(state: .tracking(newMoveEntry))
        
        // показать экран с картой
        presenter?.present(mapViewController)
    }
    
    func request(_ request: TrackingListModel.MoveEntries.HistoryRequest) {
        let mapViewController = MainFlowFactory().construct(state: .view(request.item))
        presenter?.present(mapViewController)
    }
}
