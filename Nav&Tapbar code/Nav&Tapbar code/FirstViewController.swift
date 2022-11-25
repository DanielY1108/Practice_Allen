//
//  FirstViewController.swift
//  Nav&Tapbar code
//
//  Created by JinSeok Yang on 2022/10/03.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    var isLoggedin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        setupNaviagation()
        
        
        if !isLoggedin {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    func setupNaviagation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        //navigationController?.navigationBar.prefersLargeTitles = true  // 왼쪽 큰 타이틀
        
        title = "Main"
        
        // 탭바 오른쪽 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
        
        
        
        
    }
    
    
    
    
}
