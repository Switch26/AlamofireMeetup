//
//  AlamofireManager.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 1/9/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct AlamoFireManager {
    
    static func searchMovies(withKeyword keyword: String, completionHandler: @escaping (Any)-> Void) {
        
        let url = APIGlobalUrl + "?s=\(keyword)&y=&plot=&r=json"
        
        let parameters: Parameters = ["sort": "ascending"]
        let headers: HTTPHeaders = [
            "Authorization": "Basic",
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            
            let responseCode = response.response?.statusCode
            print("Response code: \(responseCode)")
            
            switch response.result {
            case .success:
                print("Validation successfull");
                if let JSON = response.result.value {
                    completionHandler(JSON)
                }
            case .failure(let error):
                print(error.localizedDescription);
            }
        }
    }
    
    static func donwnloadFile(completionHanlder: @escaping (_ data: Data) -> Void) {
        
        let link = "http://dreamatico.com/data_images/kitten/kitten-2.jpg"
        
        Alamofire.download(link).responseData { response  in
            
            print("Response: \(response)")
            
            if let data = response.result.value {
                print("response.result.value - \(response.result.value)")
                completionHanlder(data)
            }
        }
    }
}
