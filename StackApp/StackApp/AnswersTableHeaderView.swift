//
//  AnswersTableHeaderView.swift
//  StackApp
//
//  Created by John on 12/19/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersTableHeaderView: UIView {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        questionTitleLabel.preferredMaxLayoutWidth = questionTitleLabel.bounds.width
    }
    
}
