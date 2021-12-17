//
//  RegisterViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Maxim Gilman on 02.12.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet var EmailTextBox: UITextField!
    @IBOutlet var PasswordTextBox: UITextField!
    @IBOutlet var RegisterButton: UIButton!
    @IBOutlet var ErrorLabel: UILabel!
    @IBOutlet var ConfirmPasswordTextBox: UITextField!
    @IBOutlet var BackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.text = ""
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
    
    @IBAction func onBackTap(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onRegisterTap(_ sender: UIButton) {
        guard let login = EmailTextBox.text,
              let password = PasswordTextBox.text,
              let confirm = ConfirmPasswordTextBox.text
        else { return }
        if (password != confirm)  {
            ErrorLabel.text = "Passwords are not equal"
            return
        }
        loginService.register(login: login, password: password, userName: login) { [weak self] errorMsg, userP in
            guard errorMsg == "" else {
                self?.ErrorLabel.text=errorMsg
                return }
            
            self?.ErrorLabel.text = "Successfully added"
            self?.ErrorLabel.textColor = UIColor.green
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Change `2.0` to the desired number of seconds.
                self?.dismiss(animated: true)
            }
            
        }
        
    }
    
    private func setupViews() {
        EmailTextBox.setLeftPaddingPoints(10)
        EmailTextBox.layer.cornerRadius = 20
        EmailTextBox.layer.masksToBounds = true
        
        PasswordTextBox.setLeftPaddingPoints(10)
        PasswordTextBox.layer.cornerRadius = 20
        PasswordTextBox.layer.masksToBounds = true
        
        RegisterButton.layer.cornerRadius = RegisterButton.bounds.midY
    }
}
