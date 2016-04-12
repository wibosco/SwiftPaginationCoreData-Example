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

let kStackOverflowQuestionsBaseURL: NSString = "https://api.stackexchange.com/2.2/questions?site=stackoverflow"

class Feed: NSManagedObject {

    //MARK: QuestionFeed
    
    class func questionFeed() -> Feed? {
        return Feed.questionFeed(ServiceManager.sharedInstance.mainManagedObjectContext)
    }
    
    class func questionFeed(managedObjectContext: NSManagedObjectContext) -> Feed? {
        return managedObjectContext.retrieveFirstEntry(Feed.self) as? Feed
    }
    
    //MARK: Pages
    
    func orderedPages() -> NSArray {
        let indexSort = NSSortDescriptor(key: "index", ascending: true)
        
        return (self.pages?.sortedArrayUsingDescriptors([indexSort]))!
    }
    
    func addPage(page: Page) {
        let mutablePages = self.mutableSetValueForKey("pages")
        mutablePages.addObject(page)
    }

}
