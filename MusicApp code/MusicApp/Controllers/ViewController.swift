//
//  ViewController.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/15.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let networkManager = NetworkManager.shared
        
    private let searchConroller = UISearchController(searchResultsController: CollectionViewController())
    
    private var musicArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
    }
    
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.configureWithDefaultBackground()              // 네이게이션바 불투명
        
        self.navigationItem.title = "Music Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true  // 왼쪽 큰 타이틀 설정
    }
    
    func setupSearchBar() {
        self.navigationItem.searchController = searchConroller
        
        searchConroller.searchResultsUpdater = self
        searchConroller.searchBar.autocapitalizationType = .none
//        searchConroller.searchBar.delegate = self
        
    }
    
}

extension ViewController {
    
    func setupData() {
        networkManager.fetchMusic(name: "music") { result in
            switch result {
            case .success(let musicData):
                DispatchQueue.main.async {
                    self.musicArray = musicData
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//extension ViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//        self.musicArray = []
//        networkManager.fetchMusic(name: searchText) { result in
//            switch result {
//            case .success(let result):
//                DispatchQueue.main.async {
//                    self.musicArray = result
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else { return }
//        print(text)
//        self.musicArray = []
//        networkManager.fetchMusic(name: text) { result in
//            switch result {
//            case .success(let result):
//                DispatchQueue.main.async {
//                    self.musicArray = result
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        let vc = searchController.searchResultsController as! CollectionViewController
        vc.searchMusic = searchController.searchBar.text ?? ""
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        
        let music = musicArray[indexPath.row]
        
        let url = music.artworkUrl100
        cell.mainImageView.loadFrom(URLAddress: url!)

        DispatchQueue.main.async {
         

            cell.trackNameLabel.text = music.trackName
            cell.artistNameLabel.text = music.artistName
            cell.albumLabel.text = music.collectionName
            cell.releaseDateLabel.text = music.releaseDateString
            cell.genreLabel.text = music.genreName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let previewVC = PreviewViewController()
        previewVC.musicData = musicArray[indexPath.row]
        
        navigationController?.pushViewController(previewVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}


