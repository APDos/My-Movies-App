//
//  MovieCell.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellDescLbl: UILabel!
    @IBOutlet weak var cellUrlLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(movie: Movie) {
        
        
        self.cellUrlLbl.text = movie.linkToMovie
        
        self.cellTitleLbl.text = movie.titleOfMovie
        self.cellDescLbl.text = movie.descOfMovie
        self.cellImage.image = movie.getMovieImg()
        
    }
}
