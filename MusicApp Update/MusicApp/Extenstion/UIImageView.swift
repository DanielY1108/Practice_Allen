//
//  Extension.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/16.
//

import UIKit

extension UIImageView {
    
    func loadFrom(URLAddress: String?) {
        guard let urlString = URLAddress, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard URLAddress == url.absoluteString else { return }
            guard let loadedImage = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }
}
    
