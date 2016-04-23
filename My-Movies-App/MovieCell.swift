//
//  MovieCell.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import WebKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellDescLbl: UILabel!
    
    var movieLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(movie: Movie) {
        
        
        self.movieLink = movie.linkToMovie!
        print(movie.linkToMovie)
        self.cellTitleLbl.text = movie.titleOfMovie
        self.cellDescLbl.text = movie.descOfMovie
        self.cellImage.image = movie.getMovieImg()
        
    }
    
    @IBAction func goToImdb(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: movieLink)!)
        print(movieLink)
        
        
    }
}
