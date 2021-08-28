//
//  User.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var email: String
    @Persisted var password: String
    @Persisted var createdAt: Date
    @Persisted var lasLoggedInAt: Date?
}
