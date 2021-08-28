//
//  AuthFlowPresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol AuthFlowPresenterProtocol {
    var viewController: AuthFlowDisplayProtocol? { get set }
    func present(_ response: Auth.Response.LoginError)
    func present(_ response: Auth.Response.LoginSuccess)
}

class AuthFlowPresenter: AuthFlowPresenterProtocol {
    
    weak var viewController: AuthFlowDisplayProtocol?
    
    func present(_ response: Auth.Response.LoginError) {
        viewController?.display(Auth.ViewModel.LoginError(error: response.err))
    }
    
    func present(_ response: Auth.Response.LoginSuccess) {
        viewController?.display(Auth.ViewModel.LoginSuccess())
    }
}

