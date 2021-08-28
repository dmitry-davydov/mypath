//
//  RealmManager.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    lazy private(set) var db: Realm = {
        return try! Realm()
    }()
    
    private init() {}
}
