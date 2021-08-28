//
//  SignUpViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit

protocol SignUpViewDisplayProtocol: AnyObject {
    func display(_ viewModel: SignUp.ViewModel.Success)
    func display(_ viewModel: SignUp.ViewModel.ErrorViewModel)
}

class SignUpViewController: UIViewController {
    
    var interactor: SignUpInteractorProtocol?
    
    var onEndFlow: (() -> Void)?
    
    // MARK: - Lifecycle
    override func loadView() {
        let signUpView = SignUpView()
        signUpView.delegate = self
        
        view = signUpView
    }
}

// MARK: - SignUpViewDisplayProtocol
extension SignUpViewController: SignUpViewDisplayProtocol {
    func display(_ viewModel: SignUp.ViewModel.Success) {
        let alert = UIAlertController(
            title: "Success",
            message: "You now able to login",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert, weak self]  _ in
            alert?.dismiss(animated: true, completion: { [weak self] in
                self?.onEndFlow?()
            })
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func display(_ viewModel: SignUp.ViewModel.ErrorViewModel) {
        let alert = UIAlertController(
            title: "Sign Up Error",
            message: viewModel.error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert]  _ in
            alert?.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SignUpDelegateProtocol
extension SignUpViewController: SignUpDelegateProtocol {
    func viewOnSignUp(email: String, password: String) {
        interactor?.request(SignUp.Request(email: email, password: password))
    }
    
    func viewOnSignIn() {
        onEndFlow?()
    }
}
