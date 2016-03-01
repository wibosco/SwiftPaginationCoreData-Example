//
//  Feed+CoreDataProperties.swift
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

extension Feed {

    @NSManaged var arePagesInSequence: NSNumber?
    @NSManaged var pages: NSSet?

}
