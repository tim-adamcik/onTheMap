//
//  LoginRequest.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/19/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    let udacity: [String:String]
}
