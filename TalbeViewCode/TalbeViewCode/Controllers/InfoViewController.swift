//
//  InfoViewController.swift
//  TalbeViewCode
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

class InfoViewController: UIViewController {
    
    var detail = DetailView()
    
    var movieData: Movie?
    
    override func loadView() {
        view = detail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        detail.infoImage.image = movieData?.movieImage
        detail.infoLabel.text = movieData?.movieName
        detail.infoDescription.text = movieData?.movieDescription
    }
    
    
    

}
