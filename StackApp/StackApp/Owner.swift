//
//  Owner.swift
//  StackApp
//
//  Created by John on 10/23/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

struct Owner: Codable {
    var reputation: Int?
    var user_id: Int?
    var accept_rate: Int?
    var profile_image: String?
    var display_name: String?
}