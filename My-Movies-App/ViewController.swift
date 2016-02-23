//
//  ViewController.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView!.delegate = self
        tableView!.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        addLogo()
        fetchAndSetResults()
        tableView.reloadData()
        
        for i in moviesArray {
            print(i.titleOfMovie)
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        let movie = moviesArray[indexPath.row]
        
        cell.configureCell(movie)
      
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let toBeDeleted = moviesArray[indexPath.row] as Movie
            let app = UIApplication.sharedApplication().delegate as? AppDelegate
            let context = app?.managedObjectContext
            context?.deleteObject(toBeDeleted)
            
            do {
                try context?.save()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            moviesArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
            
        }
    }
    


    func addLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 55))
        imageView.contentMode = .ScaleAspectFit
        // 4
        let image = UIImage(named: "MyMovies.png")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = app?.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context?.executeFetchRequest(fetchRequest)
            self.moviesArray = results as! [Movie]
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToFullMovie" {
            let cell = sender as! MovieCell
            let vc = segue.destinationViewController as? MovieVC
            let row = tableView.indexPathForCell(cell)!.row
            
            vc?.movies.append(moviesArray[row])
            vc?.movieNumber = row
            
        }
    }
    
}

