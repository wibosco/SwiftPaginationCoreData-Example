//
//  QuestionsAPIManager.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 28/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

class QuestionsAPIManager: NSObject {

    class func retrieveQuestions(feed: Feed, refresh: Bool, completion:((successful: Bool) -> Void)?){
        var url: NSURL
        
        if (feed.pages!.count > 0) {
            let page = feed.orderedPages().lastObject as! Page
            
            url = NSURL(string: page.nextHref!)!
        } else {
            url = NSURL(string: kStackOverflowQuestionsBaseURL as String)!
        }
        
        let feedManagedObjectID = feed.objectID
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let operation = QuestionsRetrievalOperation.init(feedID: feedManagedObjectID, data: data!, refresh: refresh, completion: completion)
                
                QueueManager.sharedInstance.queue.addOperation(operation)
            })
        }
        
        task.resume()
    }
}
