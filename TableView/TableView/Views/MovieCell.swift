//
//  MovieCell.swift
//  TableView
//
//  Created by JinSeok Yang on 2022/10/03.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var MovieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
