//
//  QuestionTableViewCell.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: ReuseIdentifier
    
    class func reuseIdentifier() -> String {
        NSNotificationCenter.defaultCenter()
        return NSStringFromClass(QuestionTableViewCell.self)
    }
    

}
