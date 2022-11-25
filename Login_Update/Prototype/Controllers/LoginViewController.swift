//
//  ViewController.swift
//  Login
//
//  Created by JinSeok Yang on 2022/10/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setDelegate()
        
        
    }
    
    
    func setDelegate() {
        loginView.delegate = self
        loginView.idTextFiled.delegate = self
        loginView.passwordTextFiled.delegate = self
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}

// MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    // animate layout
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginView.idTextFiled {
            loginView.idView.backgroundColor = .gray
            loginView.largeIdTextLabel.font = .systemFont(ofSize: 10)
            loginView.idLabelcenterYAnchor.constant = -17
        }
        
        if textField == loginView.passwordTextFiled {
            loginView.passwordView.backgroundColor = .gray
            loginView.largePasswordTextLabel.font = .systemFont(ofSize: 10)
            loginView.passwordLabelcenterYAnchor.constant = -17
        }
        
        UIView.animate(withDuration: 0.3) {
            self.loginView.totalStackView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == loginView.idTextFiled {
            loginView.idView.backgroundColor = .darkGray
            if textField.text == "" {
                loginView.largeIdTextLabel.font = .systemFont(ofSize: 18)
                loginView.idLabelcenterYAnchor.constant = 0
            }
        }
        
        if textField == loginView.passwordTextFiled {
            loginView.passwordView.backgroundColor = .darkGray
            if textField.text == "" {
                loginView.largePasswordTextLabel.font = .systemFont(ofSize: 18)
                loginView.passwordLabelcenterYAnchor.constant = 0
            }
        }
    }
    
    // check email format, minimum number of character
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
                if let email = loginView.idTextFiled.text {
                    if CheckEmail().checkEmail(str: email) || email == "" {
                        loginView.largeIdTextLabel.text = "Enter Email"
                        loginView.largeIdTextLabel.textColor = .white
        
                        if email.count >= 10 && loginView.passwordTextFiled.text!.count >= 10 {
                            loginView.longinButton.isEnabled = true
                            loginView.longinButton.backgroundColor = .red
                        } else {
                            loginView.longinButton.isEnabled = false
                            loginView.longinButton.backgroundColor = .clear
                        }
                    } else {
                        loginView.largeIdTextLabel.text = "이메일 주소를 정확히 입력해주세요"
                        loginView.largeIdTextLabel.textColor = .systemPink
                    }
        
                }
        return true
    }
    
    // tap the return button, move to the next textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginView.idTextFiled:
            loginView.passwordTextFiled.becomeFirstResponder()
        case loginView.passwordTextFiled:
            if loginView.idTextFiled.text!.count >= 10 && loginView.passwordTextFiled.text!.count >= 10 {
                didTapLoginBtn()
            }
            
        default:
            break
        }
        return false
    }
}

// MARK: - LoingView Delegate

extension LoginViewController: ViewDelegate {
    
    func didTapLoginBtn() {
        print("login")
        // default rootview is MainViewcontroller
        dismiss(animated: true)
        
    }
    
    func didTapHideBtn() {
        print("hide")
        loginView.passwordTextFiled.isSecureTextEntry.toggle()
    }
    
    func didTapResetBtn() {
        print("Password reset")
        let alert = UIAlertController(title: "RESET PASSWORD", message: "Do you wanna change password?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel")
        }))
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            print("Reset")
        }))
        
        present(alert, animated: true)
    }
    
    
    
}
