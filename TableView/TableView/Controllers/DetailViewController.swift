//
//  DetailViewController.swift
//  TableView
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieData: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
       
    }
    
    func setupUI() {
        mainImageView.image = movieData?.movieImage
        movieNameLabel.text = movieData?.movieNmae
        descriptionLabel.text = movieData?.movieDescription
    }
    
    

   

}
