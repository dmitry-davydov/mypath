//
//  AuthInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol AuthFlowLoginProtocol {
    func request(_ request: Auth.Request.Login)
}

class AuthFlowIneractor {
    var presenter: AuthFlowPresenterProtocol?
    let authService: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        authService = service
    }
    
    func request(_ request: Auth.Request.Login) {
        let result = authService.performLogin(email: request.email, password: request.password)
        switch result {
        case .success:
            presenter?.present(Auth.Response.LoginSuccess())
        case .failure(let error):
            presenter?.present(Auth.Response.LoginError(err: error))
        }
    }

}
