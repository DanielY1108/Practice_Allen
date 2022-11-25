//
//  ViewController.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/08.
//

import UIKit

class ViewController: UIViewController {
    
//        let searchController = UISearchController()
    
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    var networkManager = NetworkManager.shared
    
    var musicArrays: [Music] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        setupDatas()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        //
//                searchController.searchBar.delegate = self
        //
        //        searchController.searchBar.autocapitalizationType = .none
        
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.autocapitalizationType = .none
    }
    
    func setupTableView() {
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
        musicTableView.register(UINib.init(nibName: Cell.cellWithIdentifier, bundle: nil), forCellReuseIdentifier: Cell.cellWithIdentifier)
    }
    
    func setupDatas() {
    
        networkManager.fetchMusic(searchTerm: "pop") { result in
            switch result {
            case .success(let musicData):
                print("데이터 받음")
                self.musicArrays = musicData
                
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.cellWithIdentifier, for: indexPath) as! MyMusicCell
        
        cell.musicImage = musicArrays[indexPath.row].musicImage
        
        cell.releaseDataLabel.text = musicArrays[indexPath.row].releaseDateString
        cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
        cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}


//extension ViewController: UISearchBarDelegate {
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //        print(searchText)
    //
    //        self.musicArrays = []
    //
    //            switch result {
//            case .success(let musicDatas):
//                self.musicArrays = musicDatas
//                DispatchQueue.main.async {
//                    self.musicTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }        networkManager.fetchMusic(searchTerm: searchText) { result in
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        guard let text = searchController.searchBar.text else {
    //            return
    //        }
    //        print(text)
    //        // 다시 빈 배열로 만들기 ⭐️
    //        self.musicArrays = []
    //
    //        // 네트워킹 시작
    //        networkManager.fetchMusic(searchTerm: text) { result in
    //            switch result {
    //            case .success(let musicDatas):
    //                self.musicArrays = musicDatas
    //                DispatchQueue.main.async {
    //                    self.musicTableView.reloadData()
    //                }
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //            }
    //        }
    //        self.view.endEditing(true)
    //    }
    
//}



extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
    
}
