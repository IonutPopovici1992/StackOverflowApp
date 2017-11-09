//
//  Answer.swift
//  StackApp
//
//  Created by John on 10/3/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct Answer: Codable {
    var body: String
    var comments: [Comment]
    var owner: Owner
    var question_id: UInt
    var answer_id: UInt
    var score: UInt
    var last_activity_date: UInt
    var is_accepted: Bool
}
