//
//  ViewController.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/15.
//

import UIKit

final class MusicViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchConroller = UISearchController()
    
    private let musicManager = MusicManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
    }
    
    
    
    
}

extension MusicViewController {
    
    func setupData() {
        musicManager.defaultMusicData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.title = "Music Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true  // 왼쪽 큰 타이틀 설정
    }
    
    func setupSearchBar() {
        self.navigationItem.searchController = searchConroller
        
        searchConroller.searchBar.autocapitalizationType = .none
        searchConroller.searchBar.delegate = self
    }}


extension MusicViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchConroller.searchBar.text?.lowercased() else { return }
        print(text)
        musicManager.searchMusicData(search: text) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBar.text = searchText.lowercased()
            print(searchText)
            
        }
    }
}
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


extension MusicViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.Identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getDataFromAPI().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.Identifier, for: indexPath) as! MusicTableViewCell
        
        let music = musicManager.getDataFromAPI()[indexPath.row]
        cell.music = music

        cell.saveButtonTapped = { [weak self] (senderCell, isSaved) in
            guard let self = self else { return }
            if !isSaved {
                self.maekMessegeAlert { text, saveAction in
                    if saveAction {
                        self.musicManager.saveMusicDataFromCoreData(with: music, myMessege: text) {
                            senderCell.music?.isSaved = true
                            print(senderCell.music!.isSaved)
                            senderCell.setButtonStatus()
                            print("저장 완료")
                            dump(senderCell) //.....안 담김
                        }
                    } else {
                        print("취소됨")
                    }
                }
            } else {
                self.removeMyListAlert { RemoveAction in
                    if RemoveAction {
                        self.musicManager.deletMusicData(with: music) {
                            senderCell.music?.isSaved = false
                            senderCell.setButtonStatus()
                            print("저장된 것 삭제")
                        }
                    } else {
                        print("저장된 것 삭제 취소됨")
                    }
                }
            }
        }
        return cell
    }
    
    func maekMessegeAlert(completion: @escaping (String?, Bool) -> Void) {
        let alert = UIAlertController(title: "음악 관련 메세지", message: "음악과 함께 저장하려는 문장을 입력하세요", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "저장하려는 메세지"
        }
        var saveText: String? = ""
        let ok = UIAlertAction(title: "확인", style: .default) { okAction in
            saveText = alert.textFields?[0].text
            completion(saveText, true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(nil, false)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func removeMyListAlert(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "저장 음악 삭제", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { okAction in
            completion(true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(false)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //        let previewVC = PreviewViewController()
        //        previewVC.musicData = musicArray[indexPath.row]
        //
        //        navigationController?.pushViewController(previewVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // 탭바 숨기기
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard velocity.y != 0 else { return }
            if velocity.y < 0 {
                let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                self?.tabBarController?.tabBar.alpha = 1.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
            } else {
                self?.tabBarController?.tabBar.alpha = 0.0
                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
            }
        }
    }
    
}



