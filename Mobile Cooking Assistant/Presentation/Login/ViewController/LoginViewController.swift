//
//  LoginViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var registerButton: UIButton!
    
    private let loginService: LoginService
    
    init(loginService: LoginService = ServiceLayer.shared.loginService) {
        self.loginService = loginService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        emailTextField.text = "wtf1"
        passwordTextField.text = "wtf1"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.setGradientBackground(color: .login)
    }
    
    @IBAction private func didTapOnLogin(_ sender: Any) {
        guard let login = emailTextField.text, let password = passwordTextField.text else { return }
        loginService.logIn(login: login, password: password) { [weak self] isAuthorized in
            guard isAuthorized else { return }
            self?.dismiss(animated: true)
        }
    }
    
    @IBAction private func didTapOnRegister(_ sender: Any) {
        loginService.register { isSuccess in
            guard isSuccess else { return }
        }
    }
    
    private func setupViews() {
        emailTextField.setLeftPaddingPoints(10)
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = loginButton.bounds.midY
        registerButton.layer.cornerRadius = loginButton.bounds.midY
    }
}
