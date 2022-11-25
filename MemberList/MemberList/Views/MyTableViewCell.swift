//
//  ListViewCell.swift
//  MemberList
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // 저장 속성이 변할때 마다 업데이트
    var member: Member? {
        didSet {
            guard var member = member else { return }
            memberImageView.image = member.memberImage
            memberNameLabel.text = member.name
            memberAdressLabel.text = member.address
        }
    }
    
    let memberImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var memberNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 16, weight: .bold)
        return name
    }()
    
    var memberAdressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupAddView()
    }
    
    func setupAddView() {
        self.addSubview(memberImageView)
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(memberNameLabel)
        stackView.addArrangedSubview(memberAdressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.memberImageView.clipsToBounds = true
        self.memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
    }
    
    func setupConstraints() {
        imageConstraints()
        nameLabelConstraints()
        stackViewConstraints()
    }
    
    func imageConstraints() {
        NSLayoutConstraint.activate([
            memberImageView.heightAnchor.constraint(equalToConstant: 50),
            memberImageView.widthAnchor.constraint(equalToConstant: 50),
            memberImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            memberImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func nameLabelConstraints() {
        NSLayoutConstraint.activate([
            memberNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.memberImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.memberImageView.bottomAnchor)
        ])
    }
    
   
}
