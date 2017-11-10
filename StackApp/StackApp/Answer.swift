//
//  Answer.swift
//  StackApp
//
//  Created by John on 10/3/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct AnswerList: Codable {
    var items: [Answer]
    var has_more: Bool
    var quota_max: UInt
    var quota_remaining: UInt
}

struct Answer: Codable {
    var body: String
    var comments: [Comment]?
    var owner: Owner
    var question_id: UInt
    var answer_id: UInt
    var score: UInt
    var last_activity_date: UInt
    var is_accepted: Bool
}
