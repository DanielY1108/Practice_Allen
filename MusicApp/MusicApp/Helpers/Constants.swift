//
//  Constants.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/08.
//

import Foundation

// MARK: - Name Space

public enum MusicApi {
    static let requstUrl = "https://itunes.apple.com/search?"
    static let midiaParam = "media=music"
}


public enum Cell {
    static let cellWithIdentifier = "MyMusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
}

public struct CVCell {
    static let spacingWitdh: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}

