//
//  OTMClient.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/12/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

struct Auth {
    static var accoutId = 0
    static var requestToken = ""
    static var sessionId = ""
}

enum Endpoints {
    case students
    
    var url: URL {
        return URL(string: stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .students:
            return "https://onthemap-api.udacity.com/v1/StudentLocation"
        }
    }
    
}
