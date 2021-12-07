//
//  RegisterViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Maxim Gilman on 02.12.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet var UserNameTextBox: UITextField!
    @IBOutlet var LoginTextBox: UITextField!
    @IBOutlet var PasswordTextBox: UITextField!
    @IBOutlet var RegisterButton: UIButton!
    @IBOutlet var EmailTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NavigationBar.backBarButtonItem = UIBarButtonItem()
            //title: "Back", style: .plain, target: nil, action:nil)
    }
    private let loginService: LoginService
    

    init(loginService: LoginService = ServiceLayer.shared.loginService) {
        self.loginService = loginService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func onRegisterTap(_ sender: UIButton) {
        guard let login = LoginTextBox.text, let password = PasswordTextBox.text, let userName = UserNameTextBox.text , let email = EmailTextBox.text else { return }
        loginService.register(login: login, password: password, email: email, userName: userName) { [weak self] isAuthorized in
            guard isAuthorized else { return }
            self?.dismiss(animated: true)

    }
    
    }
    
}
