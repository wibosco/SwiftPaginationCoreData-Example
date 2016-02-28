//
//  ViewController.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

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
    
    //MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:QuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(QuestionTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! QuestionTableViewCell
        
        cell.titleLabel.text = "Title: \(indexPath.row)"
        cell.authorLabel.text = "Author: \(indexPath.row)"
        
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

