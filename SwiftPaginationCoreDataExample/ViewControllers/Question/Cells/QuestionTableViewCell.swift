//
//  QuestionTableViewCell.swift
//  SwiftPaginationCoreDataExample
//
//  Created by Home on 27/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

import PureLayout

class QuestionTableViewCell: UITableViewCell {
    
    //MARK: - Accessors
    
    lazy var titleLabel : UILabel = {
        let label = UILabel.newAutoLayoutView()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFontOfSize(15)
        
        return label
    }()
    
    lazy var authorLabel : UILabel = {
        let label = UILabel.newAutoLayoutView()
        label.font = UIFont.systemFontOfSize(14)
        
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.authorLabel)
        
        self.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Constraints
    
    override func updateConstraints() {
        self.titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: 10.0)
        self.titleLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 8.0)
        self.titleLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -10.0)
        
        /*---------------------*/
        
        self.authorLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: 10.0)
        self.authorLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -10.0)
        self.authorLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView, withOffset: -5.0)
        
        /*---------------------*/
        
        super.updateConstraints()
    }
    
    func layoutByApplyingConstraints() {
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    //MARK: - ReuseIdentifier
    
    class func reuseIdentifier() -> String {
        return NSStringFromClass(QuestionTableViewCell.self)
    }
    
    
}
