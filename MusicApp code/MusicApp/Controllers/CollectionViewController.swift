//
//  CollectionViewController.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var musicArray: [Music] = []
    
    private let networkManager = NetworkManager.shared
    
    var searchMusic: String? {
        didSet {
            setupData()
        }
    }

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .vertical
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .gray
        setupData()
        configureCollectionView()
        setupCollectionViewLayout()
    }
  
    
   
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupCollectionViewLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupData() {
        guard let safeSearchMusic = searchMusic else { return }
        networkManager.fetchMusic(name: safeSearchMusic) { result in
            switch result {
            case .success(let musicData):
                self.musicArray = musicData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MusicCollectionViewCell

        let url = musicArray[indexPath.row].artworkUrl100
        cell.backgroundColor = .lightGray
        DispatchQueue.main.async {
            print(url!)
            cell.imageCell.loadFrom(URLAddress: url!)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let previewVC = PreviewViewController()
        previewVC.musicData = musicArray[indexPath.item]
        
        present(previewVC, animated: true)
        
        
    }
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    // 콜렉션셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 50) / 4, height: (view.frame.width - 50) / 4)
    }
    // 아이템 사이 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    // 아이템 위아래 사이 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    // 공백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
 
}
