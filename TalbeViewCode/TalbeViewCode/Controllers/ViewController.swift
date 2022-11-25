//
//  ViewController.swift
//  TalbeViewCode
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit


final class ViewController: UIViewController {
    
    private var tableView = UITableView()
    
    var dataArray: [Movie] = []
    
    let dataMager = MoiveDataManger()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNaviBar()
        
        setupTableView()
        tableViewConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        
    }
    
    func setupNaviBar() {
        title = "영화목록"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    
                                                            
    }
    
    @objc func tabBarButtonTapped() {
        print(#function)
        dataMager.updateMovieData()
        dataArray = dataMager.getMovieDataArray()
        tableView.reloadData()
    }
    
    
    func setupData() {
        dataMager.movieDataMager()
        dataArray = dataMager.getMovieDataArray()
        
    }
    
    func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
    }
    
    func tableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! TableViewCell
        
        let movie = dataArray[indexPath.row]
        
        cell.movieImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.movieDescrptionLable.text = movie.movieDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = InfoViewController()
        detailVC.movieData = dataArray[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

