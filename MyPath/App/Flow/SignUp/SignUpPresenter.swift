//
//  SignUpPresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

protocol SignUpPresenterProtocol {
    var viewController: SignUpViewDisplayProtocol? { get set }
    
    func present(_ response: SignUp.Response.ErrorSignUp)
    func present(_ response: SignUp.Response.SuccessSignUp)
}

class SignUpPresenter: SignUpPresenterProtocol {
    weak var viewController: SignUpViewDisplayProtocol?
    
    func present(_ response: SignUp.Response.ErrorSignUp) {
        viewController?.display(SignUp.ViewModel.ErrorViewModel(error: response.error))
    }
    func present(_ response: SignUp.Response.SuccessSignUp) {
        viewController?.display(SignUp.ViewModel.Success())
    }
}
