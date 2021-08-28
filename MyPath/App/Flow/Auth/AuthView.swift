//
//  AuthView.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit
import SnapKit

protocol AuthViewDelegateProtocol: AnyObject {
    func viewOnLogin(email: String, password: String)
    func viewOnSignUp()
    func viewOnRememberPassword()
}

final class AuthView: UIView {
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
    
    private let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Login", for: .normal)
        view.addTarget(self, action: #selector(onLoginTap), for: .touchUpInside)
        
        return view
    }()
    
    private let signUpButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("SignUp", for: .normal)
        view.addTarget(self, action: #selector(onSignUpTap), for: .touchUpInside)
        
        return view
    }()
    
    private let rememberPasswordButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Remember password", for: .normal)
        view.addTarget(self, action: #selector(onRememberPasswordTap), for: .touchUpInside)
        
        return view
    }()
    
    private let scrollView = UIScrollView(frame: .zero)
    
    // MARK: - View Delegate
    weak var delegate: AuthViewDelegateProtocol?
    
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
        scrollView.addSubview(loginButton)
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(rememberPasswordButton)
        
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
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(80)
            make.top.equalTo(passwordView.snp.bottom).offset(16)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(8)
        }
        
        rememberPasswordButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
        }
    }
    
    
    // MARK: - Actions
    @objc private func onLoginTap(_ sender: UIButton) {
        delegate?.viewOnLogin(email: emailView.text ?? "", password: passwordView.text ?? "")
    }
    
    @objc private func onSignUpTap(_ sender: UIButton) {
        delegate?.viewOnSignUp()
    }
    
    @objc private func onRememberPasswordTap(_ sender: UIButton) {
        delegate?.viewOnRememberPassword()
    }
}
