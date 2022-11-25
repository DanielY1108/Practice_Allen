//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/15.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var stackViewPart1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateLabel, genreLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var stackViewPart2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel, albumLabel, stackViewPart1])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainImageView.image = nil
    }
    
    // MARK: - SETUP
    
    func setupCell() {
        self.addSubview(mainView)
        mainView.addSubview(mainImageView)
        mainView.addSubview(stackViewPart2)
        
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            mainImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackViewPart2.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            stackViewPart2.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            stackViewPart2.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 20),
            stackViewPart2.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
        ])
        
        
    }
    
    
}

