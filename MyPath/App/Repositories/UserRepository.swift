//
//  UserRepository.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation
import RealmSwift

enum UserRepositoryErrors: LocalizedError {
    case notFound
    case wrongPassword
    case databaseError(Error)
    
    var localizedDescription: String {
        switch self {
        case .notFound:
            return "User not found"
        case .wrongPassword:
            return "Invalid Password"
        case .databaseError(let err):
            return "Database error \(err.localizedDescription)"
        }
    }
}

protocol RepositoryProtocol: AnyObject {
    var realmManager: RealmManager { get set }
}

protocol UserRepositoryProtocol {
    func find(by email: String, password: String) -> Result<User, UserRepositoryErrors>
    func create(email: String, password: String) -> Result<Bool, UserRepositoryErrors>
    func updatePassword(email: String, password: String) -> Result<Bool, UserRepositoryErrors>
    func updateLastLoggedInAt(email: String) -> Result<Bool, UserRepositoryErrors>
}

class UserRepository: RepositoryProtocol {
    var realmManager: RealmManager
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
}

// MARK: - UserRepositoryProtocol
extension UserRepository: UserRepositoryProtocol {
    func find(by email: String, password: String) -> Result<User, UserRepositoryErrors> {
        guard let user = realmManager.db.object(ofType: User.self, forPrimaryKey: email) else {
            return .failure(.notFound)
        }
        
        guard user.password == password else {
            return .failure(.wrongPassword)
        }
        
        return .success(user)
    }
    
    func create(email: String, password: String) -> Result<Bool, UserRepositoryErrors> {
        
        if case .success(let isSuccess) = updatePassword(email: email, password: password) {
            return .success(isSuccess)
        }
        
        let user = User()
        user.email = email
        user.password = password
        user.createdAt = Date()
        
        do {
            try realmManager.db.write {
                realmManager.db.add(user)
            }
            
            return .success(true)
            
        } catch let err {
            return .failure(.databaseError(err))
        }
    }
    
    func updatePassword(email: String, password: String) -> Result<Bool, UserRepositoryErrors> {
        guard let user = realmManager.db.object(ofType: User.self, forPrimaryKey: email) else {
            return .failure(.notFound)
        }
        
        do {
            try realmManager.db.write({
                user.password = password
                realmManager.db.add(user, update: .modified)
            })
            
            return .success(true)
        } catch let err {
            return .failure(.databaseError(err))
        }
    }
    
    func updateLastLoggedInAt(email: String) -> Result<Bool, UserRepositoryErrors> {
        guard let user = realmManager.db.object(ofType: User.self, forPrimaryKey: email) else {
            return .failure(.notFound)
        }
        
        do {
            try realmManager.db.write({
                user.lasLoggedInAt = Date()
                realmManager.db.add(user, update: .modified)
            })
            
            return .success(true)
        } catch let err {
            return .failure(.databaseError(err))
        }
    }
}
