//
//  FirstViewController.swift
//  NextVC
//
//  Created by JinSeok Yang on 2022/09/27.
//

import UIKit

class FirstViewController: UIViewController {
    
    let mainLbl = UILabel()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        return button
    }()
    
    var someString: String?
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        autoLayout()
        
    }
    
    // MARK: - Set up
    
    func setup() {
        
        mainLbl.text = someString
        mainLbl.font = UIFont.systemFont(ofSize: 22)
        
        view.backgroundColor = .gray
        
        view.addSubview(mainLbl)
        view.addSubview(backButton)
        
    }
    
    // MARK: - AutoLayout
    
    func autoLayout() {
        
        mainLbl.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    // MARK: - Method
    
    @objc func backBtnTapped() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}


