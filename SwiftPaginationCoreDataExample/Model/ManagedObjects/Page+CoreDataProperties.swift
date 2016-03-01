//
//  Page+CoreDataProperties.swift
//  SwiftPaginationCoreDataExample
//
//  Created by William Boles on 29/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Page {

    @NSManaged var fullPage: NSNumber?
    @NSManaged var index: NSNumber?
    @NSManaged var nextHref: String?
    @NSManaged var feed: Feed?
    @NSManaged var questions: NSSet?

}
