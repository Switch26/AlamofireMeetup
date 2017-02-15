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
            
            guard error == nil else {
                print("Error: \(error!)")
                return completionHandler(jsonToReturn)
            }
            
            guard data != nil else {
                print("Data is nil")
                return completionHandler(jsonToReturn)
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data!) as! [String: Any] else {
                print("Not valid JSON")
                return completionHandler(jsonToReturn)
            }
            
            completionHandler(jsonObject)
            
        }
        task.resume()
        
    }
    
}
