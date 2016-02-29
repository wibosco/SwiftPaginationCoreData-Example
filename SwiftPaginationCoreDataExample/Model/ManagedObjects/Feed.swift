//
//  Feed.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 28/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData
import CoreDataServices

class Feed: NSManagedObject {

    //MARK: QuestionFeed
    
    class func questionFeed() -> Feed {
        return Feed.questionFeed(CDSServiceManager.sharedInstance().mainManagedObjectContext)
    }
    
    class func questionFeed(managedObjectContext: NSManagedObjectContext) -> Feed {
        return managedObjectContext.cds_retrieveFirstEntryForEntityClass(Feed.self) as! Feed
    }

}
