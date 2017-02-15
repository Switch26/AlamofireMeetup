//
//  AlamofireManager.swift
//  MeetupAlamofire
//
//  Created by Serguei Vinnitskii on 2/15/17.
//  Copyright © 2017 Serguei Vinnitskii. All rights reserved.
//

import UIKit
import Alamofire

struct AlamoFireManager {
    
    static func searchMovies(withKeyword keyword: String, completionHandler: @escaping (Any)-> Void) {
        
        let url = APIGlobalUrl + "?s=\(keyword)&y=&plot=&r=json"

        Alamofire.request(url).validate().responseJSON { response in
            
            let responseCode = response.response?.statusCode
            print("response code: \(responseCode)")
            
            switch response.result {
            case .success:
                print("Validation successful")
                if let JSON = response.result.value {
                    completionHandler(JSON)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

}
