//
//  Music.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/15.
//

import Foundation


// MARK: - Music
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
final class Music: Codable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let previewURL: String?
    let artworkUrl100: String?
    private let releaseDate: String?
    let genreName: String?
    var isSaved: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case artistName, collectionName, trackName
        case previewURL = "previewUrl"
        case artworkUrl100
        case releaseDate
        case genreName = "primaryGenreName"
    }
    
    // (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
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


