//
//  TableViewCell.swift
//  TalbeViewCode
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    var movieDescrptionLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [movieNameLabel, movieDescrptionLable])
        stview.spacing = 8
        stview.axis = .vertical             // 수직(vertical), 수평(horizontal)
        stview.distribution  = .fill
        stview.alignment = .fill            // 채울지 등등
        return stview
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        stackViewSubViews()
    }
    
    func stackViewSubViews() {
        self.addSubview(movieImageView)
        
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(movieDescrptionLable)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setConstraints() {
        
        movieImageViewContrarints()
        movieNameLabelContraints()
        stackViewConstraints()
    }
    
    
    func movieImageViewContrarints() {
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
         
        ])
    }
    
    func movieNameLabelContraints() {
        NSLayoutConstraint.activate([
            movieNameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.movieImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.movieImageView.bottomAnchor)
        ])
    }
    
}
