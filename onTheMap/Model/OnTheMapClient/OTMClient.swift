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
    static var id = 0
    static var key = ""
}

enum Endpoints {
    case students
    case handleLoginRequest
    
    var url: URL {
        return URL(string: stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .students:
            return "https://onthemap-api.udacity.com/v1/StudentLocation"
        case .handleLoginRequest:
            return "https://onthemap-api.udacity.com/v1/session"
        }
    }
}
    
    class func handleLoginRequest(_ username: String, _ password: String, completion: @ escaping (Int?, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.handleLoginRequest.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil {
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return }
            let message: String
            if statusCode == 403 {
                //custom error alert
            } else {
                //generic alert udacity server is down
            }
          }
            let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
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
    
    class func postStudents(completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.students.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"13334\", \"firstName\": \"Mark\", \"lastName\": \"Wender\",\"mapString\": \"Transylvania, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
            completion(error)
            return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func updateStudents(completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.students.url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"Jeff\", \"lastName\": \"Shiltz\",\"mapString\": \"Lake Wupenaco, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { 
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
}
