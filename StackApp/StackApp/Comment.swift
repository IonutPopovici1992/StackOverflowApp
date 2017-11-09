//
//  Comment.swift
//  StackApp
//
//  Created by John on 10/23/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var body: String
    var owner: Owner
    var score: Int
    var creation_date: UInt
    var comment_id: UInt
}
