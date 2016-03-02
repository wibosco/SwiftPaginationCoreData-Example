//
//  ViewController.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreDataServices
import FetchedResultsController

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Accessors
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 66
        
        tableView.registerClass(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.reuseIdentifier())
        
        return tableView
    }()
    
    lazy var feed: Feed = {
        var feed = Feed.questionFeed()
        
        if (feed == nil) {
            feed = NSEntityDescription.cds_insertNewObjectForEntityForClass(Feed.self, inManagedObjectContext: CDSServiceManager.sharedInstance().mainManagedObjectContext) as? Feed
            
            CDSServiceManager.sharedInstance().saveMainManagedObjectContext()
        }
        
        return feed!
    }()
    
    lazy var fetchedResultsController: FRCTableViewFetchedResultsController = {
        let fetchRequest = NSFetchRequest.cds_fetchRequestWithEntityClass(Question.self)
        
        let pageIndexSort = NSSortDescriptor(key: "index", ascending: true)
        let questionIndexSort = NSSortDescriptor(key: "index", ascending: true)
        
        fetchRequest.sortDescriptors = [pageIndexSort, questionIndexSort]
        
        let fetchedResultsController = FRCTableViewFetchedResultsController.init(fetchRequest: fetchRequest, managedObjectContext: CDSServiceManager.sharedInstance().mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.tableView = self.tableView
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Failed to load \(error.localizedDescription)")
        }
        
        return fetchedResultsController
    }()
    
    //MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Questions"
        
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refresh()
    }
    
    //MARK: DataRetrieval
    
    func refresh() {
        QuestionsAPIManager.retrieveQuestions(self.feed, refresh: true, completion: nil)
    }
    
    func pagination() {
        QuestionsAPIManager.retrieveQuestions(self.feed, refresh: false) { (successful) -> Void in
            //Remove pagination view
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.fetchedResultsController.fetchedObjects?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:QuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(QuestionTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! QuestionTableViewCell
        
        let question = self.fetchedResultsController.fetchedObjects![indexPath.row] as! Question
        
        cell.titleLabel.text = question.title
        cell.authorLabel.text = question.author
        
        /*---------------------*/
        
        let numberOfRowsInSection = tableView.numberOfRowsInSection(indexPath.section)
        let paginationTriggerIndex = numberOfRowsInSection - 10
        
        let triggerPagination = indexPath.row >= min(paginationTriggerIndex, numberOfRowsInSection-1)
        
        if (triggerPagination) {
            self.pagination()
        }
        
        /*---------------------*/
        
        cell.layoutByApplyingConstraints()
        
        /*---------------------*/
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

