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
    }
    
    enum ViewModel {
        struct ViewModelHistory {
            let item: MainViewController.State
        }
        
        struct ViewModelNewTrack {
            let item: MainViewController.State
        }
    }
    
    enum Track {
        struct RequestHistory {
            let item: MoveEntry
        }
        
        struct RequestNewTrack {}
        
        struct ResponseHistory {
            let item: MoveEntry
        }
        
        struct ResponseNewTrack {
            let item: MoveEntry
        }
    }
}
