//
//  MainTableViewCell.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

// MARK: - delegate

//protocol ButtonDelegate: AnyObject {
//    func cellBtnTapped()
//}
//
extension MainTableViewCell {
    func setupBtn() {

        updateButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    @objc func btnTapped() {
        updateButtonPressed?(self)

//        delegate?.cellBtnTapped()
    }
}

// MARK: - Cell

class MainTableViewCell: UITableViewCell {
    
    static var identifier = "cell"
    
    //    Delegate
    //    weak var delegate: ButtonDelegate?
    
    var updateButtonPressed: ((MainTableViewCell) -> Void)?
    
    // MARK: - Main UI
    
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = "123456789"
        return label
    }()
    
    var updateButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = .systemFont(ofSize: 9, weight: .bold)
        btn.setTitle("UPDATE", for: .normal)
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainLabel, subView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    // MARK: - Data

    var todoData: ToDoData? {
        didSet {
            configureData()
        }
    }
    
    // MARK: - Initaialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        configureCell()
        setupLayout()
        setupBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MainTableViewCell {
    
    func configureData() {
        mainLabel.text = todoData?.memoText
        dateLabel.text = todoData?.dateString
        guard let colorNum = todoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        updateButton.backgroundColor = color.buttonColor
        mainView.backgroundColor = color.backgroundColor
    }
    
    func configureCell() {
        self.addSubview(mainView)
        subView.addSubview(dateLabel)
        subView.addSubview(updateButton)
        mainView.addSubview(stackView)
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        
        mainLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        subView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            updateButton.centerYAnchor.constraint(equalTo: subView.centerYAnchor),
            updateButton.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 70),
            updateButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
        ])
        
    }
    
}
