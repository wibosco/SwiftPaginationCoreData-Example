//
//  ViewController.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    
    //MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.reuseIdentifier())
        
        self.view.addSubview(tableView)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:QuestionTableViewCell = tableView.dequeueReusableCellWithIdentifier(QuestionTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! QuestionTableViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
}

