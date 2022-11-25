//
//  DataManager.swift
//  TableView
//
//  Created by JinSeok Yang on 2022/10/03.
//

import UIKit

class DataManager {
    
    private var moviesDataArray: [Movie] = []
    
    
    func makeMovieData() {
        moviesDataArray = [
            Movie(movieImage: UIImage(named: "batman.png"), movieNmae: "배트맨", movieDescription: "배트맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "blackpanther.png"), movieNmae: "블랙팬서", movieDescription: "블랙팬서가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "captain.png"), movieNmae: "캡틴 아메리카", movieDescription: "캡틴 아메리카가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "doctorstrange.png"), movieNmae: "닥터스트레인지", movieDescription: "닥터스트레인지이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "guardians.png"), movieNmae: "가디언즈", movieDescription: "가디언즈가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "hulk.png"), movieNmae: "헐크", movieDescription: "헐크가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "ironman.png"), movieNmae: "아이언맨", movieDescription: "아이언맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "spiderman.png"), movieNmae: "스파이더맨", movieDescription: "스파이더맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "thor.png"), movieNmae: "토르", movieDescription: "토르가 출현하는 영화")
        ]
    }
    
    func getMovieData() -> [Movie] {
        
        return moviesDataArray
    }
    
    func updateMovieData() {
        let movie = moviesDataArray.randomElement()
        moviesDataArray.append(movie!)
        
        
    }
    
    
}
