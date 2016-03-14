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

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addImageBtnOutlet: UIButton!
    @IBOutlet weak var plotTextField: CustomTextView!
    @IBOutlet weak var descTextField: CustomTextView!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func searchForMovie(sender: UIButton) {
        
        let urlName = titleTextField.text
        let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let request = Alamofire.request(.GET, "http://www.omdbapi.com/?t=\(fixedUrlName)&y=&plot=short&tomatoes=true&r=json").responseJSON(completionHandler: { response in
            
            print(response.result.value)
            
        })
        
    }

    @IBAction func addImageBtn(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        sender.setTitle("", forState: .Normal)
        
    }
    
    @IBAction func createMovieBtn(sender: AnyObject) {
        
        if titleTextField.text != "" && plotTextField.text != "" && descTextField != nil && addImageBtnOutlet.imageView?.image != nil {
            
            let app = UIApplication.sharedApplication().delegate as? AppDelegate
            let context = app?.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context!)
            let movie = Movie(entity: entity!, insertIntoManagedObjectContext: context)
            movie.titleOfMovie = titleTextField.text!
            movie.plotOfMovie = plotTextField.text
            movie.descOfMovie = descTextField.text
            movie.setMovieImage((self.addImageBtnOutlet.imageView?.image)!)
            
            let urlName = titleTextField.text
            let fixedUrlName = urlName!.stringByReplacingOccurrencesOfString(" ", withString: "+")
            movie.linkToMovie = "www.imdb.com/find?s=all&q=\(fixedUrlName)" as String!
            
            context?.insertObject(movie)
            
            do {
                try context?.save()
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            navigationController?.popViewControllerAnimated(true)

        } else {
            
            let alert = UIAlertController(title: "Error", message: "Please complete all fields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        addImageBtnOutlet.setImage(image, forState: .Normal)
        addImageBtnOutlet.imageView?.contentMode = UIViewContentMode.ScaleToFill
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
 }