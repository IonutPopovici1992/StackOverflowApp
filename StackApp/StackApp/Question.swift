//
//  Question.swift
//  StackApp
//
//  Created by John on 8/29/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct QuestionList: Codable {
    var items: [Question]
    var has_more: Bool
    var quota_max: UInt
    var quota_remaining: UInt
}

struct Question: Codable {
    var title: String
    var question_id: UInt
    var creation_date: Double
    var last_activity_date: Double
    var owner: Owner
}
