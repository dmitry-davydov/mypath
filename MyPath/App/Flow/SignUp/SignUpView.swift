//
//  SignUpView.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import UIKit

protocol SignUpDelegateProtocol: AnyObject {
    func viewOnSignUp(email: String, password: String)
    func viewOnSignIn()
}


class SignUpView: UIView {
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
        view.autocorrectionType = .no
        
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
        view.autocorrectionType = .no
        return view
    }()
    
    private let signUpButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Sign Up", for: .normal)
        view.addTarget(self, action: #selector(onSignUpTap(_:)), for: .touchUpInside)
        
        return view
    }()
    
    private let signInButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("SignIn", for: .normal)
        view.addTarget(self, action: #selector(onSignInTap(_:)), for: .touchUpInside)
        
        return view
    }()
    
    private let scrollView = UIScrollView(frame: .zero)
    
    // MARK: - View Delegate
    weak var delegate: SignUpDelegateProtocol?
    
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
        scrollView.addSubview(signUpButton)
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
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(80)
            make.top.equalTo(passwordView.snp.bottom).offset(16)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
        }
    }
    
    
    // MARK: - Actions
    @objc private func onSignUpTap(_ sender: UIButton) {
        delegate?.viewOnSignUp(email: emailView.text ?? "", password: passwordView.text ?? "")
    }
    
    @objc private func onSignInTap(_ sender: UIButton) {
        delegate?.viewOnSignIn()
    }
}
