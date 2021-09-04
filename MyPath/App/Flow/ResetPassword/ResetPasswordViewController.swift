//
//  ResetPasswordViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit

protocol ResetPasswordFlowDisplayProtocol: AnyObject {
    func display(_ viewModel: ResetPassword.ViewModel.ResetPasswordSuccess)
    func display(_ viewModel: ResetPassword.ViewModel.ResetPasswordError)
}

class ResetPasswordViewController: UIViewController {
    
    var onEndFlow: (() -> Void)?
    
    // MARK: - Lifecycle
    override func loadView() {
        let resetPasswordView = ResetPasswordView()
        resetPasswordView.delegate = self
        
        view = resetPasswordView
    }
    
    var interactor: ResetPasswordInteracrotProtocol?
}


// MARK: - ResetPasswordFlowDisplayProtocol
extension ResetPasswordViewController: ResetPasswordFlowDisplayProtocol {
    func display(_ viewModel: ResetPassword.ViewModel.ResetPasswordSuccess) {
        onEndFlow?()
    }
    
    func display(_ viewModel: ResetPassword.ViewModel.ResetPasswordError) {
        
        let alert = UIAlertController(
            title: "Reset Password Error",
            message: viewModel.error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert]  _ in
            alert?.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ResetPasswordDelegateProtocol
extension ResetPasswordViewController: ResetPasswordDelegateProtocol {
    func viewOnResetPassword(email: String, password: String) {
        interactor?.request(ResetPassword.Request.NewPassword(email: email, password: password))
    }
    
    func viewOnSignIn() {
        onEndFlow?()
    }
}
