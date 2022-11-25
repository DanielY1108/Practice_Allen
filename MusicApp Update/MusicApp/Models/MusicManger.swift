//
//  MusicManger.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/19.
//

import UIKit

final class MusicManager {
    
    static let shared = MusicManager()
    
    private init() {
        fetchMusicDataFromCoreData {
            print("저장된 데이터 셋팅 완료")
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    private let coredataManager = CoreDataManager.shared
    
     var musicArray: [Music] = []
    
     var musicSavedArray: [MusicSaved] = []
    
    
    
    func getDataFromAPI() -> [Music] {
        return musicArray
    }
    
    func getDataFromCoreData() -> [MusicSaved] {
        return musicSavedArray
    }
    
    // MARK: - API

    func defaultMusicData(completion: @escaping () -> ()) {
        print("기본 Music Data Setup")
        fetchMusicDataFromAPI(searchName: "music") {
            completion()
        }
    }
    
    func searchMusicData(search: String, completion: @escaping () ->()) {
        print("search 시작")
        fetchMusicDataFromAPI(searchName: search) {
            completion()
        }
    }
    
    private func fetchMusicDataFromAPI(searchName: String, completion: @escaping () -> Void) {
        
        networkManager.fetchMusic(name: searchName) { result in
            switch result {
            case .success(let musicData):
                self.musicArray = musicData
                self.checkWhetherSaved()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                self.checkWhetherSaved()
                completion()
            }
        }
    }
    
    // MARK: - Core Data

    // 읽기
    func fetchMusicDataFromCoreData(completion: () -> Void) {
        musicSavedArray = coredataManager.getMusicSavedFromCoreData()
        completion()
    }
    
    // 생성, 저장
    func saveMusicDataFromCoreData(with music: Music, myMessege: String?, completion: @escaping () -> Void) {
        coredataManager.saveMusicSavedData(with: music, myMessege: myMessege) {
            self.fetchMusicDataFromCoreData {
                completion()
            }
        }
    }
    
    // 업데이트
    func updateMusicDataFromCoreData(newData: MusicSaved, completion: @escaping () -> Void) {
        coredataManager.updateMusicSaved(newMusicSavedData: newData) {
            self.fetchMusicDataFromCoreData {
                completion()
            }
        }
    }
    
    // 삭제
    func deleteMusicDataFromCoreData(data: MusicSaved, completion: @escaping () -> Void) {
        coredataManager.deleteMusicSaved(data: data) {
            self.fetchMusicDataFromCoreData {
                completion()
            }
        }
    }
    
    func deletMusicData(with music: Music, completion: @escaping () -> Void) {
        let musicSaved = musicSavedArray.filter { $0.trackName == music.trackName && $0.artistName == music.artistName }
        if let MyListMusicSaved = musicSaved.first {
            self.deleteMusicDataFromCoreData(data: MyListMusicSaved) {
                print("지우기 완료")
                completion()
            }
        } else {
            print("저장된 것 없음")
            completion()
        }
    }

        func checkWhetherSaved() {
            musicArray.forEach { music in
                //코어데이터에 저장된 것들 중 음악 및 가수 이름이 같은 것 찾아내서
                if musicSavedArray.contains(where: {
                    $0.trackName == music.trackName && $0.artistName == music.artistName
                }) {
                    // 이미 저장되어있는 데이터라고 설정
                    music.isSaved = true
                }
            }
        }
    }

