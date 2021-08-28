//
//  MoveEntryPath.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import Foundation
import RealmSwift

class MoveEntryPath: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    @Persisted var date: Date
    
    // reversed one to many relation
    @Persisted(originProperty: "pathList") var moveEntry: LinkingObjects<MoveEntry>
    
    convenience init(latitude: Double, longitude: Double, date: Date) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
}
