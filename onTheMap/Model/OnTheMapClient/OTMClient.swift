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
    static var id = ""
    static var key = ""
}

enum Endpoints {
    case students
    case handleLoginRequest
    case deleteRequest
    case userInfo
    case postStudents
    
    var url: URL {
        return URL(string: stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .students:
            return "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100?order=-updatedAt"
        case .handleLoginRequest:
            return "https://onthemap-api.udacity.com/v1/session"
        case .deleteRequest:
            return "https://onthemap-api.udacity.com/v1/session"
        case .userInfo:
            return "https://onthemap-api.udacity.com/v1/users/" + Auth.id
        case .postStudents:
            return "https://onthemap-api.udacity.com/v1/session"
        }
    }
}
    
    class func handleLoginRequest(_ username: String, _ password: String, completion: @ escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.handleLoginRequest.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                let errorTemp = NSError(domain:"", code: statusCode, userInfo:nil)
                completion(false, errorTemp)
                return
            }
            if let data = data {
                let range = 5..<data.count
                let newData = data.subdata(in: range) /* subset response data! */
                guard let json = try? JSONSerialization.jsonObject(with: newData, options: []) as? [String:Any] else { return }
                if let accountDict = json["account"] as? [String:Any],
                    let sessionDict = json["session"] as? [String:Any],
                    let key = accountDict["key"] as? String,
                    let id = sessionDict["id"] as? String {
                    Auth.key = key
                    Auth.id = id
                    completion(true, nil)
                }
            }
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
    
    class func postStudents(body: StudentLocation, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.students.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(body.uniqueKey)\", \"firstName\": \"\(body.firstName)\", \"lastName\": \"\(body.lastName)\",\"mapString\": \"\(body.mapString)\", \"mediaURL\": \"\(body.mediaURL)\",\"latitude\": \(body.latitude), \"longitude\": \(body.longitude)}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
            completion(error)
            return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func updateStudents(body: StudentLocation, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.students.url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(body.uniqueKey)\", \"firstName\": \"\(body.firstName)\", \"lastName\": \"\(body.lastName)\",\"mapString\": \"\(body.mapString)\", \"mediaURL\": \"\(body.mediaURL)\",\"latitude\": \(body.latitude), \"longitude\": \(body.longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil {
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func deleteSession(completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: Endpoints.deleteRequest.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func getUserInfo(completion: @escaping (Error?) -> Void) {
        let request = URLRequest(url: Endpoints.userInfo.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if let error = error {
            completion(error)
              return
          }
          if let data = data {
              let range = 5..<data.count
              let newData = data.subdata(in: range) /* subset response data! */
              guard let json = try? JSONSerialization.jsonObject(with: newData, options: []) as? [String:Any] else { return }
              if let firstName = json["first_name"] as? String,
                let lastName = json["last_name"] as? String {
                AccountManager.shared.firstName = firstName
                AccountManager.shared.lastName = lastName
                completion(nil)
              }
            }
        }
        task.resume()
    }
}
