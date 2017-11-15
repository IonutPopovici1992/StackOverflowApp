//
//  AnswersTableViewCell.swift
//  StackApp
//
//  Created by John on 11/13/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
