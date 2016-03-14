//
//  Movie+CoreDataProperties.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 3/14/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var descOfMovie: String?
    @NSManaged var imageOfMovie: NSData?
    @NSManaged var linkToMovie: String?
    @NSManaged var plotOfMovie: String?
    @NSManaged var titleOfMovie: String?
    @NSManaged var tomatoMeter: String?
    @NSManaged var releaseDate: String?
    @NSManaged var rating: String?
    @NSManaged var runtime: String?
    @NSManaged var metaScore: String?
    @NSManaged var imdbRating: String?
    @NSManaged var tomatoUrl: String?

}
