//
//  NetworkManager.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/15.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataError
    case parseError
}

final class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    func fetchMusic(name: String, completion: @escaping NetworkCompletion) {
        
        let strUrl = "\(Constant.url)=\(name)"
        print(strUrl)
        
        performRequest(with: strUrl) { result in
            completion(result)
        }
    }
    
    
    private func performRequest(with strUrl: String, completion: @escaping NetworkCompletion) {
        
        guard let url = URL(string: strUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, responde, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completion(.failure(.urlError))
                return
            }
            guard let safeData = data else {
                print("Erroe Data")
                completion(.failure(.dataError))
                return
            }
            guard let musicData = self.parseJSON(safeData) else {
                print("Parse Error")
                completion(.failure(.parseError))
                return
            }
            completion(.success(musicData))
            print("데이터 얻음")
            return
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> [Music]? {
        
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: data)
            return musicData.results
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
