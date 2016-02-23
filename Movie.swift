//
//  Movie.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Movie: NSManagedObject {
    
    

    //set image
    func setMovieImage(img: UIImage) {
        let image = UIImagePNGRepresentation(img)
        self.imageOfMovie = image!
    }
    
    //get image
    func getMovieImg() -> UIImage {
        let image = UIImage(data: self.imageOfMovie!)
        return image!
    }
    

}
