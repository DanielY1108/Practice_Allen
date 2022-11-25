//
//  DetailView.swift
//  TalbeViewCode
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

class DetailView: UIView {
    
    var infoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    var infoDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    var stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 15
        return sv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupInfoUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func setupInfoUI() {
        stackView.addArrangedSubview(infoImage)
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(infoDescription)
        
        self.addSubview(stackView)
    }
    
    override func updateConstraints() {
        setupContraints()
        super.updateConstraints()
    }
    
    
    func setupContraints() {
        infoImageConstraints()
        infoLabelContraints()
        infoDescriptionContraints()
        stackViewConstraints()
        
    }
    
    func infoImageConstraints() {
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoImage.heightAnchor.constraint(equalToConstant: 240),
            infoImage.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func infoLabelContraints() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func infoDescriptionContraints() {
        infoDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
    }
    
    
    
}
