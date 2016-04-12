//
//  Parser.swift
//  SwiftPaginationCoreDataExample
//
//  Created by William Boles on 12/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreData


class Parser: NSObject {
    
    //MARK: Accessors
    
    var localManagedObjectContext: NSManagedObjectContext
    
    //MARK: Init
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.localManagedObjectContext = managedObjectContext
        
        super.init()
    }
}
