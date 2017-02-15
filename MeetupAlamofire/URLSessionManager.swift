//
//  URLSessionManager.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 2/15/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import Foundation

let APIGlobalUrl = "http://www.omdbapi.com/"

struct URLSessionManager {
    
    static func searchMovies(forKeyword keyword: String, completionHandler: @escaping (_ json: [String: Any]) -> Void) {
        
        let url = APIGlobalUrl + "?s=\(keyword)&y=&plot=&r=json"
        let jsonToReturn = [String: Any]() // empty dictionary
        
        let formattedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let formatedURL = URL(string: formattedString)!
        var request = URLRequest(url: formatedURL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error: \(error!)")
                completionHandler(jsonToReturn)
            } else {
                if data == nil {
                    print("Data is nil")
                    completionHandler(jsonToReturn)
                } else {
                    do {
                        let jsonToReturn = try JSONSerialization .jsonObject(with: data!) as! [String: Any]
                        print(jsonToReturn)
                        completionHandler(jsonToReturn)
                    } catch {
                        print("Not valid JSON")
                        completionHandler(jsonToReturn)
                    }
                }
            }
        }
        task.resume()
        
    }
    
}
