//
//  RequestPasswordPresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol ResetPasswordPresenterProtocol {
    
    var viewController: ResetPasswordFlowDisplayProtocol? { get set }
    
    func present(_ response: ResetPassword.Response.NewPasswordError)
    func present(_ response: ResetPassword.Response.NewPasswordSuccess)
}

class ResetPasswordPresenter: ResetPasswordPresenterProtocol {
    
    weak var viewController: ResetPasswordFlowDisplayProtocol?
    
    func present(_ response: ResetPassword.Response.NewPasswordError) {
        viewController?.display(ResetPassword.ViewModel.ResetPasswordError(error: response.error))
    }
    
    func present(_ response: ResetPassword.Response.NewPasswordSuccess) {
        viewController?.display(ResetPassword.ViewModel.ResetPasswordSuccess())
    }
}
