//
//  Movie+CoreDataProperties.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var titleOfMovie: String?
    @NSManaged var descOfMovie: String?
    @NSManaged var plotOfMovie: String?
    @NSManaged var imageOfMovie: NSData?
    @NSManaged var linkToMovie: String?

}
