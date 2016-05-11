//
//  MovieCell.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

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
        
        let urlName = movie.titleOfMovie
        let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        Alamofire.request(.GET, "http://www.omdbapi.com/?t=\(fixedUrlName)&y=&plot=short&tomatoes=true&r=json").responseJSON(completionHandler: { response in
            
            if let json = response.result.value as? [String: String] {

                    if let poster = json["Poster"] where poster != "N/A" {
                        
                        let url = NSURL(string: poster)
                        
                        print(url)
                        let data = NSData(contentsOfURL: url!)
                        self.cellImage.image = UIImage(data: data!)
                        
                        
                    }
                
                
            }
            
        })
        
    }
    
    @IBAction func goToImdb(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: movieLink)!)
        print(movieLink)
        
        
    }
}
