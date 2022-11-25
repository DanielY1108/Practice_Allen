//
//  MusicCollectionViewCell.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    let imageCell: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: self.topAnchor),
            imageCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.imageCell.image = nil
    }
    
}
