//
//  MainViewController.swift
//  Login
//
//  Created by JinSeok Yang on 2022/10/12.
//

import UIKit

class MainViewController: UIViewController {
    
    private var isLoggedIn = false
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
   
        checkLogin()

    }
    
    func checkLogin() {
        
        if !isLoggedIn {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }
    
    
    
    
}
