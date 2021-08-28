//
//  AuthService.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol AuthServiceProtocol {
    var loggedInUser: User? { get set }
    
    func performLogin(email: String, password: String) -> Result<User, Error>
    func performSignUp(email: String, password: String) -> Result<Bool, Error>
    func performResetPassword(email: String, password: String) -> Result<Bool, Error>
    func performLogout()
}

class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    let repository: UserRepositoryProtocol
    
    private init() {
        repository = UserRepository(realmManager: RealmManager.shared)
    }
    
    var loggedInUser: User?
    
    func performLogin(email: String, password: String) -> Result<User, Error> {
        let result = repository.find(by: email, password: password)
        
        switch result {
        case .success(let user):
            _ = repository.updateLastLoggedInAt(email: email)
            loggedInUser = user
            return .success(user)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func performSignUp(email: String, password: String) -> Result<Bool, Error> {
        let result = repository.create(email: email, password: password)
        switch result {
        case .success(let isSuccess):
            return .success(isSuccess)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func performResetPassword(email: String, password: String) -> Result<Bool, Error> {
        let result = repository.updatePassword(email: email, password: password)
        switch result {
        case .success(let isSuccess):
            return .success(isSuccess)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    func performLogout() {
        loggedInUser = nil
    }
}
