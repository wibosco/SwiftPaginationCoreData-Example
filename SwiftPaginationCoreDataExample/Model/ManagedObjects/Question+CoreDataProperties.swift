//
//  Question+CoreDataProperties.swift
//  SwiftPaginationCoreDataExample
//
//  Created by William Boles on 01/03/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Question {

    @NSManaged var title: String?
    @NSManaged var author: String?
    @NSManaged var questionID: NSNumber?
    @NSManaged var index: NSNumber?
    @NSManaged var page: Page?

}
