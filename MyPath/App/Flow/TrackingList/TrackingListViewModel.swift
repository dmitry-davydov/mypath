//
//  TrackingListViewModel.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import Foundation

enum TrackingListModel {
    
    enum MoveEntries {
        struct Request {}
        struct Response {
            let items: [MoveEntry]
        }
        
        struct HistoryRequest {
            let item: MoveEntry
        }
    }
    
    enum NewMove {
        struct Request {}
    }
}
