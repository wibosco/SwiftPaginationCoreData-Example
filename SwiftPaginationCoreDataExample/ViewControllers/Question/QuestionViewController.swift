//
//  ViewController.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreData
import CoreDataServices
import FetchedResultsController

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewFetchedResultsControllerDelegate {
    
    //MARK: - Accessors
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        
        tableView.backgroundColor = UIColor.whiteColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 66
        
        tableView.addSubview(self.pullToRefreshControl)
        
        tableView.registerClass(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.reuseIdentifier())
        
        return tableView
    }()
    
    lazy var feed: Feed = {
        var feed = Feed.questionFeed()
        
        if (feed == nil) {
            feed = NSEntityDescription.insertNewObjectForEntity(Feed.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext) as? Feed
            
            ServiceManager.sharedInstance.saveMainManagedObjectContext()
        }
        
        return feed!
    }()
    
    lazy var fetchedResultsController: TableViewFetchedResultsController = {
        let fetchRequest = NSFetchRequest.fetchRequest(Question.self)
        
        let pageIndexSort = NSSortDescriptor(key: "index", ascending: true)
        let questionIndexSort = NSSortDescriptor(key: "index", ascending: true)
        
        fetchRequest.sortDescriptors = [pageIndexSort, questionIndexSort]
        
        let fetchedResultsController = TableViewFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.tableView = self.tableView
        fetchedResultsController.dataDelegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Failed to load \(error.localizedDescription)")
        }
        
        return fetchedResultsController
    }()
    
    lazy var pullToRefreshControl: UIRefreshControl = {
        let pullToRefreshControl = UIRefreshControl()
        
        pullToRefreshControl.addTarget(self, action: #selector(QuestionViewController.pullToRefreshDragged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return pullToRefreshControl
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
        QuestionsAPIManager.retrieveQuestions(self.feed, refresh: true) { (successful) in
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue(), {
                self.pullToRefreshControl.endRefreshing()
            })
            
            print("refreshed")
        }
    }
    
    func pagination() {
        QuestionsAPIManager.retrieveQuestions(self.feed, refresh: false) { (successful) -> Void in
            print("paginated")
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
    
    //MARK: - PullToRefresh
    
    func pullToRefreshDragged(sender: UIRefreshControl) {
        self.refresh()
    }
    
    //MARK: TableViewFetchedResultsControllerDelegate
    
    func didUpdateContent() {
        self.pullToRefreshControl.endRefreshing()
    }
}

