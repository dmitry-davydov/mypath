//
//  AuthViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit
import SnapKit

protocol AuthFlowDisplayProtocol: AnyObject {
    func display(_ viewModel: Auth.ViewModel.LoginSuccess)
    func display(_ viewModel: Auth.ViewModel.LoginError)
}

class AuthViewController: UIViewController, AuthFlowDisplayProtocol {
    var onRememberPassword: (() -> Void)?
    var onSignIn: (() -> Void)?
    var onSignUp: (() -> Void)?
    
    var interactor: AuthFlowIneractor?
        
    // MARK: - Controller Lifecycle
    override func loadView() {
        let authView = AuthView()
        authView.delegate = self
        
        view = authView
    }
    
    // MARK: - AuthFlowDisplayProtocol
    
    func display(_ viewModel: Auth.ViewModel.LoginSuccess) {
        onSignIn?()
    }
    
    func display(_ viewModel: Auth.ViewModel.LoginError) {
        let alert = UIAlertController(title: "Login Error", message: viewModel.error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - AuthViewDelegateProtocol
extension AuthViewController: AuthViewDelegateProtocol {
    func viewOnLogin(email: String, password: String) {
        print("on login \(email) \(password)")
        
        interactor?.request(Auth.Request.Login(email: email, password: password))
        
    }
    
    func viewOnSignUp() {
        onSignUp?()
    }
    
    func viewOnRememberPassword() {
        onRememberPassword?()
    }
    
    
}
