//
//  StudentLocation.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/14/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let createdAt: Date
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: Date
}
