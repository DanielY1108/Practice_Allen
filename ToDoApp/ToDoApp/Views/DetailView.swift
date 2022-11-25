//
//  DetailView.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

protocol buttonDelegate: AnyObject {
    func colorButtonTapped(_: UIButton)
    func updateButtonTapped(_: DetailView)
}

class DetailView: UIView {
    
    weak var delegate: buttonDelegate?

    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var mainTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14)
        text.backgroundColor = .clear
        return text
    }()
    
    let redButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("Red", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.tag = 1
        return btn
    }()
    
    let greenButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("Green", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.tag = 2
        return btn
    }()
    
    let blueButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("Blue", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.tag = 3
        return btn
    }()
    
    let purpleButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("Purple", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.tag = 4
        return btn
    }()
    
    let updateButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("UPDATE", for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 4
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton, purpleButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var allStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonStackView, mainView, updateButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var buttons: [UIButton] = [redButton, greenButton, blueButton, purpleButton]
    
    
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
        addButtonTarger()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.backgroundColor = .black

        super.layoutSubviews()
        buttons.forEach { button in
            button.layer.cornerRadius = 35 / 2
            button.clipsToBounds = true
        }
    }
 
    
}

extension DetailView {
    
    func addButtonTarger() {
        for x in buttons {
            x.addTarget(self, action: #selector(colorButtonPress), for: .touchUpInside)
        }
        updateButton.addTarget(self, action: #selector(updateButtonPress), for: .touchUpInside)
        
    }
    
    @objc func updateButtonPress() {
        delegate?.updateButtonTapped(self)
    }
    
    @objc func colorButtonPress(_ sender: UIButton) {
        delegate?.colorButtonTapped(sender)
    }
    
    // MARK: - SET UP

    func configureView() {
        mainView.addSubview(mainTextView)
        self.addSubview(allStackView)
    }
    
    func configureLayout() {
        
        mainTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        
        buttonStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            mainTextView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            mainTextView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            mainTextView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            allStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            allStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            allStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
    }
    
}

