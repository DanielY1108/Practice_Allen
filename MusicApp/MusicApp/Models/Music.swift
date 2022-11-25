//
//  Music.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/08.
//

import Foundation
import UIKit

// MARK: - Music
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
struct Music: Codable {
    let artistName, albumName, songName: String?
    let previewURL: String?
    let musicImage: String?
    private let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case songName = "trackName"
        case previewURL = "previewUrl"
        case musicImage = "artworkUrl100"
        case releaseDate
    }
    
    
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
        
    
}
