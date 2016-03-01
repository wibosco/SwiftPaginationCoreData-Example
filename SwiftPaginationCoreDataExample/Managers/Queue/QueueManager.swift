//
//  QueueManager.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 28/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

class QueueManager: NSObject {
    
    //MARK: Accessors
    
    lazy var queue: NSOperationQueue = {
        let queue = NSOperationQueue()
        
        return queue;
    }()
    
    //MARK: - SharedInstance
    
    static let sharedInstance = QueueManager()
}
