//
//  Owner.swift
//  StackApp
//
//  Created by John on 10/23/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct Owner: Codable {
    var display_name: String
    var profile_image: String?
    var user_id: Int
    var user_type: String?
    var reputation: Int?
    var accept_rate: Int?
}
