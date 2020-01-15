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
    
    class func getStudents(completion: @escaping ([StudentLocation], Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: Endpoints.students.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
         let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLocationResponse.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
    }
        task.resume()
    }
    
    class func postStudents(completion: @escaping ([StudentLocation], Error?) -> Void) {
        var request = URLRequest(url: Endpoints.students.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"13334\", \"firstName\": \"Mark\", \"lastName\": \"Wender\",\"mapString\": \"Transylvania, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            if error != nil {
                print(String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
}
