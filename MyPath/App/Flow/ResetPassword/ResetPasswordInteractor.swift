//
//  ResetPasswordInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol ResetPasswordInteracrotProtocol {
    func request(_ request: ResetPassword.Request.NewPassword)
}


class ResetPasswordInteractor: ResetPasswordInteracrotProtocol {
    
    var presenter: ResetPasswordPresenterProtocol?
    
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
    }
    
    // MARK: - ResetPasswordInteracrotProtocol
    func request(_ request: ResetPassword.Request.NewPassword) {
        let result = service.performResetPassword(email: request.email, password: request.password)
        switch result {
        case .success:
            presenter?.present(ResetPassword.Response.NewPasswordSuccess())
        case .failure(let error):
            presenter?.present(ResetPassword.Response.NewPasswordError(error: error))
        }
    }
}
