//
//  MainView.swift
//  Login
//
//  Created by JinSeok Yang on 2022/10/12.
//

import UIKit

class LoginView: UIView {
    
    weak var delegate: ViewDelegate?
    
    // MARK: - email field
    
    lazy var idView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    lazy var largeIdTextLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 18)
        lable.textColor = .white
        lable.text = "Enter Email"
        return lable
    }()
    
    lazy var idTextFiled: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 18)
        tf.keyboardType = UIKeyboardType.emailAddress  // 키보드 타입
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.autocorrectionType = .no                    // 자동 수정 동작
        tf.spellCheckingType = .no                     // 맞춤법 검사
        tf.becomeFirstResponder()                      // 화면에서 첫번째로 반응(포커스 시킴)
        tf.autocapitalizationType = .none
        tf.textColor = .white
        return tf
    }()
    
    // MARK: - Password Field
    
    lazy var passwordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    lazy var largePasswordTextLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 18)
        lable.textColor = .white
        lable.text = "Enter Password"
        return lable
    }()

    lazy var passwordTextFiled: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 18)
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // MARK: - Button
    
    lazy var longinButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.layer.cornerRadius = 7
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.isEnabled = true
        btn.addTarget(self, action: #selector(loginTapepd), for: .touchUpInside)
        return btn
    }()
    
    private lazy var passwordHideButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Hide", for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(hideTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var passwordReset: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reset", for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(resetTapepd), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - StackView (ID, Password, Button)
    
    lazy var totalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [idView, passwordView, longinButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 18
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK: - move Label
    
    lazy var idLabelcenterYAnchor = largeIdTextLabel.centerYAnchor.constraint(equalTo: idView.centerYAnchor)
    
    lazy var passwordLabelcenterYAnchor = largePasswordTextLabel.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor)
    
    
    // MARK: - intitalize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        totalLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    @objc func loginTapepd() {
        delegate?.didTapLoginBtn()
    }
    
    @objc func resetTapepd() {
        delegate?.didTapResetBtn()
    }
    
    @objc func hideTapped() {
        delegate?.didTapHideBtn()
    }
    
    // MARK: - Layout
    
    private func totalLayout() {
        
        self.addSubview(totalStackView)
        self.addSubview(passwordReset)
        
        idView.addSubview(largeIdTextLabel)
        idView.addSubview(idTextFiled)
        
        passwordView.addSubview(largePasswordTextLabel)
        passwordView.addSubview(passwordTextFiled)
        passwordView.addSubview(passwordHideButton)
        
        
        NSLayoutConstraint.activate([
            idView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // ID layout
        NSLayoutConstraint.activate([
//            largeIdTextLabel.centerYAnchor.constraint(equalTo: idView.centerYAnchor),
            largeIdTextLabel.leadingAnchor.constraint(equalTo: idView.leadingAnchor, constant: 10),
            largeIdTextLabel.trailingAnchor.constraint(equalTo: idView.trailingAnchor, constant: -10),
            idLabelcenterYAnchor
        ])
        
        NSLayoutConstraint.activate([
            idTextFiled.centerYAnchor.constraint(equalTo: idView.centerYAnchor, constant: 2),
            idTextFiled.leadingAnchor.constraint(equalTo: idView.leadingAnchor, constant: 10),
            idTextFiled.trailingAnchor.constraint(equalTo: idView.trailingAnchor, constant: -10),
        ])
        
        // Password layout
        NSLayoutConstraint.activate([
//            largePasswordTextLabel.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            largePasswordTextLabel.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            largePasswordTextLabel.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),
            passwordLabelcenterYAnchor
        ])
        
        NSLayoutConstraint.activate([
            passwordTextFiled.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor, constant: 2),
            passwordTextFiled.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            passwordTextFiled.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            passwordHideButton.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            passwordHideButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),
            passwordHideButton.widthAnchor.constraint(equalToConstant: 40),
            passwordHideButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        // stackView layout
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            totalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            totalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15),
        ])
        
        // Reset Button
        NSLayoutConstraint.activate([
            passwordReset.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordReset.widthAnchor.constraint(equalToConstant: 60),
            passwordReset.topAnchor.constraint(equalTo: totalStackView.bottomAnchor, constant: 18),
        ])
    }
    
    
    
}
