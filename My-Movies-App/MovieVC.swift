//
//  MovieVC.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import CoreData
class MovieVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieURL: UILabel!
    
    var currentMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAndSetResults()
        configureScreen(currentMovie)

        // Do any additional setup after loading the view.
    }

    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = app?.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context?.executeFetchRequest(fetchRequest)
            self.currentMovie = results![0] as! Movie
            print(currentMovie)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func configureScreen(movie: Movie) {
        titleLbl.text = movie.titleOfMovie
        movieImg.image = UIImage(data: movie.imageOfMovie!)
        movieDesc.text = movie.descOfMovie
        moviePlot.text = movie.plotOfMovie
        movieURL.text = movie.linkToMovie
    }
    
}
