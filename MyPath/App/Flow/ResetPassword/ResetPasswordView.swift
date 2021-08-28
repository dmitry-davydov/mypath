//
//  ResetPasswordView.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit

protocol ResetPasswordDelegateProtocol: AnyObject {
    func viewOnResetPassword(email: String, password: String)
    func viewOnSignIn()
}

class ResetPasswordView: UIView {
    // MARK: - View
    private let emailView: UITextField = {
        let view = UITextField(frame: .zero)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.cornerRadius = 4
        view.keyboardType = .emailAddress
        view.placeholder = "Email"
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 32))
        view.leftViewMode = .always
        
        return view
    }()
    
    private let passwordView: UITextField = {
        let view = UITextField(frame: .zero)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.cornerRadius = 4
        view.isSecureTextEntry = true
        view.placeholder = "Password"
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 32))
        view.leftViewMode = .always
        return view
    }()
    
    private let resetPasswordButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Reset password", for: .normal)
        view.addTarget(self, action: #selector(onResetPasword), for: .touchUpInside)
        
        return view
    }()
    
    private let signInButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("SignIn", for: .normal)
        view.addTarget(self, action: #selector(onSignInTap), for: .touchUpInside)
        
        return view
    }()
    
    private let scrollView = UIScrollView(frame: .zero)
    
    // MARK: - View Delegate
    weak var delegate: ResetPasswordDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        
        scrollView.addSubview(emailView)
        scrollView.addSubview(passwordView)
        scrollView.addSubview(resetPasswordButton)
        scrollView.addSubview(signInButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emailView.snp.makeConstraints { make in
            
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerY.equalTo(self.snp.centerY).offset(-160)
            make.height.equalTo(32)
        }
        
        passwordView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(emailView.snp.bottom).offset(8)
            make.height.equalTo(32)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(80)
            make.top.equalTo(passwordView.snp.bottom).offset(16)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(8)
        }
    }
    
    
    // MARK: - Actions
    @objc private func onResetPasword(_ sender: UIButton) {
        delegate?.viewOnResetPassword(email: emailView.text ?? "", password: passwordView.text ?? "")
    }
    
    @objc private func onSignInTap(_ sender: UIButton) {
        delegate?.viewOnSignIn()
    }
}
