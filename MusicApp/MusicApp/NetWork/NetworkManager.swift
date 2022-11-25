//
//  NetworkManager.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/08.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataError
    case parseError
}

final class NetworkManager {
    
    static let shared = NetworkManager()  // 싱글통
    private init() {}  // 생성자 접근 제한
    
//    let musicUrl = "https://itunes.apple.com/search?medial=misic&term=pop"
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        
        let strUrl = "\(MusicApi.requstUrl)?\(MusicApi.midiaParam)&term=\(searchTerm)"
        print(strUrl)
        
        performRequest(with: strUrl) { result in
            completion(result)
            
        }
        
    }
    
    
    private func performRequest(with srtUrl: String, completion: @escaping NetworkCompletion) {
        
        // URL요청 생성
        guard let url = URL(string: srtUrl) else { return }
        
        // 요청을 가지고 작업세션시작
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completion(.failure(.urlError))
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Erroe Data")
                completion(.failure(.dataError))
                return
            }
            
            if let music = self.parseJSON(safeData) {
                print("parse 실행")
                completion(.success(music))
            } else {
                print("parse 에러")
                completion(.failure(.parseError))
            }
            
        }
        task.resume()     // 시작
        
    }
    
    private func parseJSON(_ data: Data) -> [Music]? {
        
        do {
            let musicData =  try JSONDecoder().decode(MusicData.self, from: data)
            return musicData.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    
}
