//
//  MovieVC.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class MovieVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieDesc: CustomTextView!
    @IBOutlet weak var moviePlot: CustomTextView!
    
    @IBOutlet weak var releasedLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var metaLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    @IBOutlet weak var rottenLbl: UILabel!
    
    
    var movieNumber = 0
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        
        configureScreen(movies[movieNumber])
        print(movies[movieNumber])
        
    }
    
    

    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = app?.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context?.executeFetchRequest(fetchRequest)
            self.movies = results as! [Movie]
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func configureScreen(movie: Movie) {
        
        titleLbl.text = movie.titleOfMovie
        
        movieDesc.text = movie.descOfMovie
        moviePlot.text = movie.plotOfMovie
        
        ratingLbl.text = movie.rating
        metaLbl.text = movie.metaScore
        imdbLbl.text = movie.imdbRating
        rottenLbl.text = movie.tomatoMeter
        
        releasedLbl.text = movie.releaseDate
        lengthLbl.text = movie.runtime
        
        
        let urlName = movie.titleOfMovie
        let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        Alamofire.request(.GET, "http://www.omdbapi.com/?t=\(fixedUrlName)&y=&plot=short&tomatoes=true&r=json").responseJSON(completionHandler: { response in
            
            if let json = response.result.value as? [String: String] {
                
                if let poster = json["Poster"] where poster != "N/A" {
                    
                    let url = NSURL(string: poster)
                    
                    print(url)
                    let data = NSData(contentsOfURL: url!)
                    self.movieImg.image = UIImage(data: data!)
                    
                    
                }
                
                
            }
            
        })
        
    }
    
}
