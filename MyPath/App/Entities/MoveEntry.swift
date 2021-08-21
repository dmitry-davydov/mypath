//
//  MoveEntry.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import Foundation
import RealmSwift

class MoveEntry: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var startAt: Date
    @Persisted(indexed: true) var endAt: Date?
    
    // one to many relation
    @Persisted var pathList: List<MoveEntryPath>
    
    convenience init(startAt: Date) {
        self.init()
        
        self.startAt = startAt
    }
}
