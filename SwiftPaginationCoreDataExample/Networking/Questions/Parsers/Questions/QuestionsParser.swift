//
//  QuestionsParser.swift
//  SwiftPaginationCoreDataExample
//
//  Created by William Boles on 29/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreData
import CoreDataServices

class QuestionsParser: NSObject {
    
    //MARK: Questions
    
    func parseQuestions(questionsRetrievalResponse: NSDictionary) -> Page {
        let page = NSEntityDescription.insertNewObjectForEntity(Page.self, managedObjectContext: ServiceManager.sharedInstance.backgroundManagedObjectContext) as! Page
        
        let questionResponses = questionsRetrievalResponse["items"]
        
        for (var index = 0; index < questionResponses!.count; index++) {
            let questionResponse = questionResponses![index] as! NSDictionary
            
            let question = self.parseQuestion(questionResponse)
            question.index = index
            
            if (question.page == nil) {
                question.page = page
            } else {
                page.fullPage = false
            }
        }
        
        return page
    }
    
    //MARK: Question
    
    func parseQuestion(questionResponse: NSDictionary) -> Question {
        let questionID = questionResponse["question_id"] as! NSInteger
        
        let predicate = NSPredicate(format: "questionID == %d", questionID)
        
        var question = ServiceManager.sharedInstance.backgroundManagedObjectContext.retrieveFirstEntry(Question.self, predicate: predicate) as? Question
        
        if (question == nil) {
            question = NSEntityDescription.insertNewObjectForEntity(Question.self, managedObjectContext: ServiceManager.sharedInstance.backgroundManagedObjectContext) as? Question
            
            question?.questionID = questionID
        }
        
        question?.title = questionResponse["title"] as? String
        
        let authorResponse = questionResponse["owner"] as! NSDictionary
        
        question?.author = authorResponse["display_name"] as? String
        
        return question!
    }
}
