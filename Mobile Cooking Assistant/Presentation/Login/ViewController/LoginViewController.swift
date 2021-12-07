//
//  LoginViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit
import GoogleSignIn
final class LoginViewController: UIViewController {
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var registerButton: UIButton!    
    @IBOutlet private var googleButton: GIDSignInButton!
    
    
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
        let registerViewController = RegisterViewController()
        registerViewController.modalPresentationStyle = .fullScreen
        self.present(registerViewController, animated: true)    
    }
    
    @IBAction func didTapOnGoogle(_ sender: GIDSignInButton) {
        let signInConfig = GIDConfiguration.init(clientID: "206916034058-blb7q55t03cpfnhi8tifr7vt8u3jvt7j.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            self.dismiss(animated: true)

            // If sign in succeeded, display the app's main content View.
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
        registerButton.layer.cornerRadius = registerButton.bounds.midY
    }
}
