//
//  MappableObjects.swift
//  StackApp
//
//  Created by John on 9/14/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation
import ObjectMapper

struct QuestionMappable: Mappable {
    var title: String?
    var last_activity_date: UInt?
    var question_id: UInt?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        last_activity_date <- map["last_activity_date"]
        question_id <- map["question_id"]
    }
}

struct AnswerMappable: Mappable {
    var comments: [Comment]?
    var owner: Owner?
    var is_accepted: Bool?
    var score: UInt?
    var last_activity_date: UInt?
    var creation_date: UInt?
    var answer_id: UInt?
    var question_id: UInt?
    var body: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        comments <- map["comments"]
        owner <- map["owner"]
        is_accepted <- map["is_accepted"]
        score <- map["score"]
        last_activity_date <- map["last_activity_date"]
        creation_date <- map["creation_date"]
        answer_id <- map["answer_id"]
        question_id <- map["question_id"]
        body <- map["body"]
    }
}

struct Comment: Mappable {
    var owner: Owner?
    var score: Int?
    var creation_date: UInt?
    var comment_id: UInt?
    var body: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        owner <- map["owner"]
        score <- map["score"]
        creation_date <- map["creation_date"]
        comment_id <- map["comment_id"]
        body <- map["body"]
    }
}

struct Owner: Mappable {
    var reputation: Int?
    var user_id: Int?
    var accept_rate: Int?
    var profile_image: String?
    var display_name: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        reputation <- map["reputation"]
        user_id <- map["user_id"]
        accept_rate <- map["accept_rate"]
        profile_image <- map["profile_image"]
        display_name <- map["display_name"]
    }
}
