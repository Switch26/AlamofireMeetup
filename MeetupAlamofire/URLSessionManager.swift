//
//  API_Manager.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 1/8/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit

enum APICallError: Error {
    case networkError(String)
    case parsingJSONError
    case serverError
}


let APIGlobalUrl = "http://www.omdbapi.com/"

struct URLSessionManager {
    
    static func searchMovies(forKeyword keyword: String, completionHandler: @escaping (_ json: [String: Any], _ error: APICallError?) -> Void) {
        
        let url = APIGlobalUrl + "?s=\(keyword)&y=&plot=&r=json"
        let jsonToReturn = [String: Any]() // empty dictionary
        
        // prepare URLSession (boilerplate code)
        let formatedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let formatedURL = URL(string: formatedString)!
        var request = URLRequest(url: formatedURL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error: \(error!)")
                completionHandler(jsonToReturn, APICallError.networkError(error!.localizedDescription))
            } else {
                if data == nil {
                    print("Data is nil")
                    completionHandler(jsonToReturn, APICallError.serverError)
                } else {
                    do {
                        let jsonToReturn = try JSONSerialization .jsonObject(with: data!) as! [String: Any]
                        completionHandler(jsonToReturn, nil)
                    } catch {
                        print("Not valid JSON")
                        completionHandler(jsonToReturn, APICallError.parsingJSONError)
                    }
                }
            }
        }
        task.resume()
        
    }
}


















/*
 guard error == nil else {
 print("Error: \(error!)")
 return completionHandler(nil) // think of handling this error
 }
 
 guard data != nil else {
 print("Data is nil")
 return completionHandler(nil) // data is nil
 }
 
 guard let jsonObject = try? JSONSerialization.jsonObject(with: data!) as! [String: Any] else {
 print("Not valid JSON")
 return completionHandler(nil) // can't parse JSON
 }
 
 completionHandler(jsonObject)
 */
