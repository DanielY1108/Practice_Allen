//
//  SearchViewController.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/19.
//

import UIKit

final class myListViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let musicManager = MusicManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }
    
    func setupUI() {
        tableView.register(SavedMusicViewCell.self, forCellReuseIdentifier: SavedMusicViewCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.title = "Music Search"
        self.navigationController?.navigationBar.prefersLargeTitles = false  // 왼쪽 큰 타이틀 설정
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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

extension myListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getDataFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedMusicViewCell.Identifier, for: indexPath) as! SavedMusicViewCell
        
        let musicSaved = self.musicManager.getDataFromCoreData()[indexPath.row]
        cell.musicSaved = musicSaved
        
        cell.saveButtonTapped = { [weak self] (senderCell) in
            guard let self = self else { return }
            self.removeMyListAlert { RemoveAction in
                if RemoveAction {
                    self.musicManager.deleteMusicDataFromCoreData(data: musicSaved) {
                        senderCell.setButtonStatus()
//                        self.tableView.reloadData()
                        
                        print("저장된 것 삭제")
                    }
                } else {
                    print("저장된 것 삭제 취소됨")
                }
            }
        }
        return cell

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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
 
    
}
