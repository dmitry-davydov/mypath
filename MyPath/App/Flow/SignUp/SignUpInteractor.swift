//
//  SignUpInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol SignUpInteractorProtocol {
    func request(_ request: SignUp.Request)
}

class SignUpInteractor {
    var presenter: SignUpPresenterProtocol?
    
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
    }
}

// MARK: - SignUpInteractorProtocol
extension SignUpInteractor: SignUpInteractorProtocol {
    func request(_ request: SignUp.Request) {
        let result = service.performSignUp(email: request.email, password: request.password)
        switch result {
        case .success:
            presenter?.present(SignUp.Response.SuccessSignUp())
        case .failure(let error):
            presenter?.present(SignUp.Response.ErrorSignUp(error: error))
        }
    }
}
