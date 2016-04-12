//
//  QuestionsRetrievalOperation.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 28/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreData
import CoreDataServices

class QuestionsRetrievalOperation: NSOperation {
    
    //MARK: Accessors
    
    var feedID : NSManagedObjectID
    var data : NSData
    var refresh : Bool
    var completion : ((successful: Bool) -> (Void))?
    var callBackQueue : NSOperationQueue
    
    //MARK: Init
    
    init(feedID: NSManagedObjectID, data: NSData, refresh: Bool, completion: ((successful: Bool) -> Void)?) {
        self.feedID = feedID
        self.data = data
        self.refresh = refresh
        self.completion = completion
        self.callBackQueue = NSOperationQueue.currentQueue()!
        
        super.init()
    }
    
    //MARK: Main
    
    override func main() {
        super.main()
    
        do {
            let jsonResponse = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            ServiceManager.sharedInstance.backgroundManagedObjectContext.performBlockAndWait({ () -> Void in
                let parser = QuestionsParser(managedObjectContext: ServiceManager.sharedInstance.backgroundManagedObjectContext)
                let page = parser.parseQuestions(jsonResponse) as Page
                
                do {
                    print("self.feedID: \(self.feedID)")
                    
                    let feed = try ServiceManager.sharedInstance.backgroundManagedObjectContext.existingObjectWithID(self.feedID) as! Feed
                    
                    let nextPageNumber = (feed.pages?.count)! + 1
                    
                    page.nextHref = "\(kStackOverflowQuestionsBaseURL)&page=\(nextPageNumber)"
                    page.index = self.indexOfNextPageToBeAdded(feed)
                    
                    self.reorderIndexes(feed)
                    
                    if (self.refresh) {
                        let fullPage = page.fullPage as! Bool
                        
                        feed.arePagesInSequence = !fullPage
                    }
                    
                    feed.addPage(page)
                    
                    /*----------------*/
                    
                    ServiceManager.sharedInstance.saveBackgroundManagedObjectContext()
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    
                    self.callBackQueue.addOperationWithBlock({ () -> Void in
                        if (self.completion != nil) {
                            self.completion!(successful: false)
                        }
                    })
                }
            })
            
            /*----------------*/
            
            if (self.completion != nil) {
                self.completion!(successful: true)
            }
            
        } catch let error as NSError {
            print("Failed to load \(error.localizedDescription)")
            
            self.callBackQueue.addOperationWithBlock({ () -> Void in
                if (self.completion != nil) {
                    self.completion!(successful: false)
                }
            })
        }
    }
    
    //MARK: Index
    
    func indexOfNextPageToBeAdded(feed: Feed) -> NSNumber {
        var indexOfNextPageToBeAdded: NSNumber
        
        if self.refresh {
            indexOfNextPageToBeAdded = -1
        } else {
            indexOfNextPageToBeAdded = feed.pages!.count
        }
        
        return indexOfNextPageToBeAdded
    }
    
    func reorderIndexes(feed: Feed) {
        let pages = feed.orderedPages()
        
        for (var index = 0; index < pages.count; index++) {
            let page = pages[index] as! Page
            page.index = index
        }
    }
}
