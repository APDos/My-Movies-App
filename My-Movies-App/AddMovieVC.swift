//
//  AddMovieVC.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import Alamofire

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var plotTextField: CustomTextView!
    @IBOutlet weak var descTextField: CustomTextView!
    
    @IBOutlet weak var metaRating: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var rottenRating: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieLength: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var movieImg: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        activityIndicator.hidesWhenStopped = true
        self.titleTextField.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        
        doneKeyboardButton()
        
    }
    
    
    @IBAction func searchForMovie(sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        let urlName = titleTextField.text
        let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        Alamofire.request(.GET, "http://www.omdbapi.com/?t=\(fixedUrlName)&y=&plot=short&tomatoes=true&r=json").responseJSON(completionHandler: { response in
            
            if let json = response.result.value as? [String: String] {
                
                if json.count == 2 {
                    
                    self.activityIndicator.stopAnimating()
                    self.displayErrorMessage("Error", message: "Cannot find movie")
                    
                } else {
                    
                    if let poster = json["Poster"] where poster != "N/A" {
                        
                        let url = NSURL(string: poster)
                        
                        print(url)
                        let data = NSData(contentsOfURL: url!)
                        self.movieImg.image = UIImage(data: data!)
                        
                        
                    }
                    
                    self.plotTextField.text = json["Plot"]
                    
                    self.releaseDate.text = json["Released"]
                    self.movieLength.text = json["Runtime"]
                    self.movieRating.text = json["Rated"]
                    
                    self.metaRating.text = "\(json["Metascore"]!)/100"
                    self.imdbRating.text = "\(json["imdbRating"]!)/10"
                    self.rottenRating.text = "\(json["tomatoMeter"]!)%"
                    
                    self.activityIndicator.stopAnimating()
                    self.view.endEditing(true)
                    
                }

            }
            
        })
        
    }
    
    @IBAction func saveMovieBtn(sender: AnyObject) {
        
        if plotTextField.text != nil && descTextField.text != "" {
            
            print("Begin saving")
            
            let app = UIApplication.sharedApplication().delegate as? AppDelegate
            let context = app?.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context!)
            let movie = Movie(entity: entity!, insertIntoManagedObjectContext: context)
            
            movie.titleOfMovie = titleTextField.text?.capitalizedString
            movie.plotOfMovie = plotTextField.text
            movie.descOfMovie = descTextField.text
            movie.releaseDate = releaseDate.text
            movie.runtime = movieLength.text
            movie.rating = movieRating.text
            movie.metaScore = metaRating.text
            movie.imdbRating = imdbRating.text
            movie.tomatoMeter = rottenRating.text
            //movie.setMovieImage(self.movieImg.image!)
            
            let urlName = titleTextField.text
            let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
            movie.linkToMovie = "http://www.imdb.com/find?s=all&q=\(fixedUrlName)" as String!
            
            context?.insertObject(movie)
            
            do {
                try context?.save()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            navigationController?.popViewControllerAnimated(true)

        } else {
            
            displayErrorMessage("Error", message: "Please complete all fields")
            
        }
        
        
    }
    
    func displayErrorMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func doneKeyboardButton() {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonPressed))
        keyboardToolbar.items = [flexBarButtonItem, doneBarButtonItem]
        self.descTextField.inputAccessoryView = keyboardToolbar
        
    }
    
    func doneButtonPressed() {
        self.descTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    


    
 }