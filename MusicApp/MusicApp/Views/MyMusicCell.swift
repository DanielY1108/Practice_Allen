//
//  MyMusicCell.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/08.
//

import UIKit

class MyMusicCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    var musicImage: String? {
        didSet {
            guard let safeImage = musicImage else { return }
            loadImage(urlAddress: safeImage)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView.contentMode = .scaleToFill
        
    }
    
    func loadImage(urlAddress: String) {
        guard let url = URL(string: urlAddress) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlAddress == url.absoluteString else { return }

            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: imageData)
            }
        }
    }
}



