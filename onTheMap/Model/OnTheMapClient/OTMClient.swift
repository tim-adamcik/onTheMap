//
//  OTMClient.swift
//  onTheMap
//
//  Created by Timothy Adamcik on 1/12/20.
//  Copyright © 2020 Timothy Adamcik. All rights reserved.
//

import Foundation

class OTMClient {
    
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
    
    class func taskForGetRequest(completion: @escaping ([StudentLocation], Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.students.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
         let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode([StudentLocation].self, from: data)
                completion(responseObject, nil)
            } catch {
                completion([], error)
            }
    }
        task.resume()
    }
}
