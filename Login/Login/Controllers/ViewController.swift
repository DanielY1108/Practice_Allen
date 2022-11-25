//
//  ViewController.swift
//  Login
//
//  Created by JinSeok Yang on 2022/09/26.
//

import UIKit

final class ViewController: UIViewController {
    
    private var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddTarget()
        
    }
    
    // MARK: - Method
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func resetButtonTapped() {
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .actionSheet)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("취소버튼이 눌렸습니다.")
        }
        alert.addAction(success)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)  // 다음화면으로 넘어가는 메서드
        
    }
    
    @objc func loginButtonTapped() {
        print("로그인 버튼이 눌렀습니다")
    }
    
    
}

