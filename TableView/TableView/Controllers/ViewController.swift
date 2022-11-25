//
//  ViewController.swift
//  TableView
//
//  Created by JinSeok Yang on 2022/10/03.
//

import UIKit

class ViewController: UIViewController {
    
    //    var moviesArray: [Movie] = []
    
    var movieDataManager = DataManager()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        setupDatas()
        
    }

    func setupTableView() {
        
        tableView.rowHeight = 120
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "영화목록"
        
    }
    
    func setupDatas() {
        
        movieDataManager.makeMovieData()
        //        moviesArray = movieDataManager.getMovieDataManager()
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
        movieDataManager.updateMovieData()
        tableView.reloadData()
        
    }
    
    
}

// MARK: - 데이터 관리 -

extension ViewController: UITableViewDataSource {
    
    // (numberOfRowsInSection) 몇 개의 컨텐츠를 표시할 것인가?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        
        return movieDataManager.getMovieData().count
    }
    
    // (cellForRowAt) 셀을 만든다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movicell", for: indexPath) as! MovieCell
        
        let movie = movieDataManager.getMovieData()[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.MovieNameLabel.text = movie.movieNmae
        cell.descriptionLabel.text = movie.movieDescription
        //        cell.selectionStyle = .none
        
        
        return cell
    }
    
}

// MARK: - 델리게이트 -

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath)
        // sender로 밑의 함수에서도 쓸 수 있게 보내준다.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            let DetailVC = segue.destination as! DetailViewController
            
            let array = movieDataManager.getMovieData()
            //위에서 받은 indexPath(sender)를 IndexPath으로 형변환
            let indexPath = sender as! IndexPath
            
            DetailVC.movieData = array[indexPath.row]  // 전달하기 원하는 영화 데이터
            
        }
    }
    
}
